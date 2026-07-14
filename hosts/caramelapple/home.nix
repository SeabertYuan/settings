{ config, pkgs, lib, dotfiles, ... }:
{
  imports = [
    ../../home/default.nix
  ];

  home.homeDirectory = lib.mkForce "/Users/seabert";

  home.packages = with pkgs; [
    gh
  ];
}
