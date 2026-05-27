{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "caramelapple";
  networking.localHostName = "caramelapple";

  system.stateVersion = 6;
  system.primaryUser = "seabert";

  environment.shells = [ pkgs.bash ];
  users.users.seabert.shell = pkgs.bash;

  environment.systemPath = [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
      "sccache"
      "pi-coding-agent"
      "podman"
    ];
    casks = [
      "anki"
      "nordvpn"
      "codex"
      "slack"
      "beekeeper-studio"
      "blender"
      "gimp"
      "maccy"
      "orbstack"
      "podman-desktop"
      "thunderbird"
      "spotify"
      "discord"
      "signal"
    ];
  };
}
