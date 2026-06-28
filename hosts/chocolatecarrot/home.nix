{ pkgs, ... }:
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
}
