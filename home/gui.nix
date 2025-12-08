{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.blex-mono
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
    source-sans
    source-serif
    # icon theme
    adwaita-icon-theme
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Source Serif" ];
      sansSerif = [ "Source Sans" ];
      monospace = [ "JetBrainsMono NFP" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  gtk = {
    enable = true;
    # iconTheme = {
    #   name = "Adwaita";          # Match the theme's internal name
    #   package = pkgs.adwaita-icon-theme;
    # };
    # cursorTheme = {
    #   name = "Adwaita";          # Match the theme's internal name
    #   package = pkgs.adwaita-icon-theme;
    # };
    gtk2.extraConfig = ''
      gtk-im-module="fcitx"
    '';
    gtk3.extraConfig = {
      gtk-im-module="fcitx";
      gtk-font-name="Source Sans 11";
    };
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };
}
