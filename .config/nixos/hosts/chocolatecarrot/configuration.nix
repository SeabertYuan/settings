# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, unstable, attrs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  _module.args.unstable = import attrs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  # opengl
  hardware = {
    graphics.enable = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # GRUB
  # boot.loader.grub.device = nodev;
  # boot.loader.grub.efiSupport = true;

  networking.hostName = "chocolatecarrot"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.wireless.iwd.enable = true;
  networking.nftables.enable = true;

  # Set your time zone.
  time.timeZone = "Canada/Pacific";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  # for multilang input
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons  = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-mozc-ut
      fcitx5-hangul
    ];
  };
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  services.udev.extraRules = ''
    KERNEL=="i2c-13", GROUP="i2c"
  '';

  # proper font size rendering in xserver
  # services.xserver.dpi = 101;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  services.tlp.enable = true; 

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.seabert = {
    isNormalUser = true;
    home = "/home/seabert";
    extraGroups = [ "wheel" "libvirtd" "kvm" "i2c" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      # utilities
      grim
      slurp
      wl-clipboard
      yazi
      fzf
      bc
      playerctl
      pavucontrol # I'm too dumb to figure out cmdline but i want to
      libnotify
      fswatch # faster lsp
      tectonic # latex
      pplatex # better latex errors
      ddcutil # external monitor brightness
      # apps
      zathura
      mpv
      feh
      obsidian
      spotify
      discord
      signal-desktop
      obs-studio
      # dev
      rustup
      jdk
      python3
      luajit
      luarocks # luacheck for nvim
      nodejs_22
      unstable.tree-sitter
      # biome
      # rust-analyzer
      lua-language-server
      jdt-language-server
    ];
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
    "obsidian"
    "discord"
  ];


  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerdfonts
      (callPackage ../../packages/fonts/source-sans-3.nix {})
      (callPackage ../../packages/fonts/source-serif-4.nix {})
    ];
    fontconfig.defaultFonts = {
      serif = [ "Source Serif 4" ];
      sansSerif = [ "Source Sans 3" ];
      monospace = [ "JetBrainsMono NFP" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  services.gnome.gnome-keyring.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      mako
      brightnessctl
      foot
      swayidle
      swaylock
      wmenu
    ];
  };

  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    environment = {
      WAYLAND_DISPLAY="wayland-1";
      DISPLAY = ":0";
    };
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c /home/seabert/.config/kanshi/config'';
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  programs.thunderbird.enable = true;
  programs.firefox.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    unstable.neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    tmux
    git
    ripgrep
    fastfetch
    btop
    glibc
    libgcc
    gcc
    killall
    alsa-utils
    unzip
    fontconfig
    mesa
    ffmpeg
    i2c-tools

    ## virtualisation
    # python312Packages.click
    # python312Packages.tqdm
    # virt-manager
    # qemu_full
    # vde2
    # ebtables
    # iptables
    # nftables
    # dnsmasq
    # bridge-utils
    # OVMF
    # qemu-utils
    # dosfstools
    # tk-9_0
  ];

	#  programs.virt-manager.enable = true;
	#
	#  virtualisation.libvirtd = {
	#    enable = true;
	#    qemu = {
	#      package = pkgs.qemu_kvm;
	#      runAsRoot = true;
	#      swtpm.enable = true;
	#      ovmf = {
	#        enable = true;
	# packages = [(pkgs.OVMF.override {
	#   secureBoot = true;
	#   tpmSupport = true;
	# }).fd];
	#      };
	#      verbatimConfig = ''
	#        user = "seabert"
	# group = "seabert"
	#      '';
  #   };
  #   extraConfig = ''
  #     unix_sock_rw_perms = "0770"
  #     log_filters="3:qemu 1:libvirt"
  #     log_outputs="2:file:/var/log/libvirt/libvirtd.log"
  #   '';
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 57621 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

