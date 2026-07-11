{ inputs, pkgs, ... }:
{
  imports = [
    ../../home/default.nix
    ../../home/gui.nix
  ];

  home.homeDirectory = "/home/seabert";

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
    # apps
    chromium
    anki
    # widgets
    eww
    # media
    qimgv
    obs-studio
    darktable
    audacity
    blender
    easyeffects # EQ
  ];

  home.file = let inherit (inputs) dotfiles; in {
    ".config/sway/resources/wallpaper.jpg".source = pkgs.fetchurl {
      url = "https://pub-31e5e043a7bb4d65b3b5e1775518429c.r2.dev/host-resources/Kanagawa.jpg";
      hash = "sha256-RKhIar3wMwo/5rWG5AdQbnOP4HX+C138Q5YeNY/acgY=";
    };
    ".config/sway/resources/wallpaper-blur.jpg".source = pkgs.fetchurl {
      url = "https://pub-31e5e043a7bb4d65b3b5e1775518429c.r2.dev/host-resources/Kanagawa_blur.jpg";
      hash = "sha256-Af6PTQsQN/xezcCyl+sKRTGiuyCtNpueIc4fkACq+rU=";
    };
    ".config/sway" = {
      source = "${dotfiles}/sway";
      recursive = true;
    };
  };
}
