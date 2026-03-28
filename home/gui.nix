{ config, pkgs, ... }:
{
  my.vim.package = pkgs.vim-full;

  home.packages = with pkgs; [
    # fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.blex-mono
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
    source-sans
    source-serif
  ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
    # icon theme
    adwaita-icon-theme
    # unfree apps
    spotify
    discord
    # apps
    chromium
    thunderbird
    signal-desktop
    zathura
    mpv
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Source Serif 4" ];
      sansSerif = [ "Source Sans 3" ];
      monospace = [ "JetBrainsMono NFP" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  gtk = {
    enable = true;
    gtk2.extraConfig = ''
      gtk-im-module="fcitx"
    '';
    gtk3.extraConfig = {
      gtk-im-module="fcitx";
      gtk-font-name="Source Sans 3 11";
    };
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };
}
