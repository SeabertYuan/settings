{ config, pkgs, lib, ... }:
{
  imports = [
    ../../home/default.nix
    ../../home/gui.nix
  ];

  home.homeDirectory = lib.mkForce "/Users/seabert";
}
