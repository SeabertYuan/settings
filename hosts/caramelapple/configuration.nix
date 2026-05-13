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
    ];
    casks = [
      "nordvpn"
      "wezterm@nightly"
      "codex"
      "slack"
      "beekeeper-studio"
      "blender"
      "gimp"
      "maccy"
      "orbstack"
      "thunderbird"
      "spotify"
      "discord"
      "signal"
    ];
  };
}
