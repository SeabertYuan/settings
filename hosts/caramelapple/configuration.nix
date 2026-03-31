{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "caramelapple";
  networking.localHostName = "caramelapple";

  system.stateVersion = 6;
  system.primaryUser = "seabert";

  environment.shells = [ pkgs.bash ];
  users.users.seabert.shell = pkgs.bash;

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    casks = [
      "claude-code"
      "codex"
      "slack"
      "beekeeper-studio"
      "blender"
      "maccy"
      "orbstack"
      "thunderbird"
      "spotify"
      "discord"
      "signal"
    ];
  };
}
