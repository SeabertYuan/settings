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

  home.homeDirectory = "/home/seabert";

  # programs.bash = {
  #   profileExtra = ''
  #     [[ -f ~/.bashrc ]] && . ~/.bashrc

  #     #for IME support
  #     # export QT_IM_MODULE=fcitx

  #     export XDG_CURRENT_DESKTOP=sway

  #     export UV_PYTHON_DOWNLOADS=never
  #   '';
  # };

  home.sessionVariables = {
    XMODIFIERS="@im=fcitx";
    GLFW_IM_MODULE = "ibus";
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "network.protocol-handler.external.spotify" = true;
        "network.protocol-handler.warn-external.spotify" = false;
      };
    };
  };

  home.packages = with pkgs; [
    # unfree
    obsidian
    spotify
    discord
    claude-code
    # apps
    chromium
    # dependency for brightness/audio
    bc
    signal-desktop
    zathura
    mpv
    qimgv
    obs-studio
    darktable
    audacity
    anki
    blender
    easyeffects # EQ
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
