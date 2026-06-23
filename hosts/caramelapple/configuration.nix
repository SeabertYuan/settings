{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

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

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
      extraFlags = [ "--force-cleanup" ];
    };
    brews = [
      "sccache"
      "pi-coding-agent"
      "podman"
    ];
    casks = [
      "wezterm@nightly"
      "nikitabobko/tap/aerospace"
      "anki"
      "nordvpn"
      "codex"
      "slack"
      "beekeeper-studio"
      "blender"
      "darktable"
      "gimp"
      "maccy"
      "orbstack"
      "podman-desktop"
      "thunderbird"
      "spotify"
      "discord"
      "signal"
      "telegram"
    ];
  };
}
