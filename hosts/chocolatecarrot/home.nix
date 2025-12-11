{ config, pkgs, ... }:
let
  obsidianSyncScript = pkgs.writeShellScriptBin "sync-obsidiansea" ''
    #!/bin/sh

    DATE="$(date +"%m.%d.%y")"

    GITDIR="/home/seabert/Documents/ObsidianSea/"

    git --git-dir=$GITDIR.git --work-tree=$GITDIR/ pull > /dev/null 2>&1

    echo $DATE

    IS_DIFF=$(git --git-dir=$GITDIR.git --work-tree=$GITDIR/ diff --name-only)

    if ! [[ -z "$IS_DIFF" ]]; then
      git --git-dir=$GITDIR.git --work-tree=$GITDIR/ add .
      RES=$(git --git-dir=$GITDIR.git --work-tree=$GITDIR/ commit -m "$DATE")
      RES+=$(git --git-dir=$GITDIR.git --work-tree=$GITDIR/ push)
      notify-send "$RES"
    else
      notify-send "failed to sync changes"
    fi
  '';
in
{
  imports = [
    ../../home/default.nix
    ../../home/gui.nix
  ];

  programs.bash = {
    profileExtra = ''
      [[ -f ~/.bashrc ]] && . ~/.bashrc

      eval "$(luarocks path)"

      #for IME support
      export XMODIFIERS=@im=fcitx
      # export QT_IM_MODULE=fcitx
      export GLFW_IM_MODULE=ibus

      export XDG_CURRENT_DESKTOP=sway

      export UV_PYTHON_DOWNLOADS=never
    '';
  };

  home.packages = with pkgs; [
    # unfree
    obsidian
    spotify
    discord
    # utilties
    grim
    slurp
    wl-clipboard
    yazi
    mediainfo # for a plugin for yazi
    fzf
    bc
    # apps
    signal-desktop
    zathura
    mpv
    feh
    qimgv
    obs-studio
    darktable
    audacity
    anki
    ardour
    blender
    easyeffects # EQ
    # dev
    rustup
    jdk
    python3
    luajit
    luarocks # luacheck for nvim
    nodejs_22
    tree-sitter
    uv
    # biome
    # rust-analyzer
    lua-language-server
    jdt-language-server

  ];

  # some nice services
  systemd.user = {
    services = {
      "sync-obsidiansea" = {
        Unit = {
          Description = "Synchronizes ObsidianSea";
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${obsidianSyncScript}/bin/sync-obsidiansea.sh";
          WorkingDirectory = config.home.homeDirectory;
          StandardOutput = "journal";
          StandardError = "journal";
        };
      };
    };
    timers = {
      "sync-obsidiansea" = {
        Unit = {
          Description = "Sync ObsidianSea daily at 19:30PM Vancouver time (PT).";
        };
        Timer = {
          OnCalendar = "*-*-* 19:30:00 Canada/Pacific";
          Persistent = true;
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}
