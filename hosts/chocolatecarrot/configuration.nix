# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, unstable, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  _module.args.unstable = import inputs.nixpkgs-unstable {
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
  networking.useNetworkd = true;

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [ 57621 ];
    interfaces.wg0.allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ 51820 5353 ];
  };

  systemd.network = {
    enable = true;
    networks."50-wg0" = {
      matchConfig.Name = "wg0";
      address = [ "10.100.0.1/24" ];

      networkConfig = {
	IPv4Forwarding = true;
	IPv6Forwarding = true;
      };
    };

    netdevs."50-wg0" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "wg0";
      };

      wireguardConfig = {
        ListenPort = 51820;

        # ensure file is readable by `systemd-network` user
        PrivateKeyFile = config.age.secrets.wg-key-chocolatecarrot.path;

        # To automatically create routes for everything in AllowedIPs,
        # add RouteTable=main
        RouteTable = "main";

        # FirewallMark marks all packets send and received by wg0
        # with the number 42, which can be used to define policy rules on these packets.
        FirewallMark = 42;
      };
      wireguardPeers = [
        {
          # laptop wg conf
          PublicKey = "x3GvdXo1EN6j8kHFLFdwwjWUTOit8dOyxdpsYSg10Xo=";
          AllowedIPs = [ "10.100.0.2/32" ];

          # RouteTable can also be set in wireguardPeers
          # RouteTable in wireguardConfig will then be ignored.
          # RouteTable = 1000;
        }
      ];
    };
  };

  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  age.secrets.wg-key-chocolatecarrot = {
    file = ../../secrets/wg-key-chocolatecarrot.age;
    path = "/run/wireguard/wg-key-chocolatecarrot";
    symlink = false;
    owner = "systemd-network";
    group = "systemd-network";
    mode = "0400";
  };
  age.identityPaths = [
    "/root/.ssh/id_ed25519"
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_rsa_key"
  ];

  system.activationScripts.agenixChown.deps = lib.mkAfter [ "agenixInstall" ];

  # Set your time zone.
  time.timeZone = "Canada/Pacific";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

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
      qt6Packages.fcitx5-chinese-addons
      fcitx5-mozc-ut
      fcitx5-hangul
    ];
  };
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c"

    KERNEL=="uinput", MODE="0660", GROUP="input"
  '';

  # proper font size rendering in xserver
  # services.xserver.dpi = 101;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  services.tlp.enable = true; 

  # docker
  virtualisation.docker.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.extraConfig.bluetoothEnhancements = {
      "monitor.bluez.properties" = {
	  "bluez5.enable-sbc-xq" = true;
	  "bluez5.enable-msbc" = true;
	  "bluez5.enable-hw-volume" = true;
	  "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
      };
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.seabert = {
    isNormalUser = true;
    home = "/home/seabert";
    extraGroups = [ "wheel" "libvirtd" "kvm" "i2c" "docker"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      # TODO: this stuff is dependencies for stuff I need to move to home-manager
      # utilities
      playerctl
      pavucontrol # I'm too dumb to figure out cmdline but i want to
      libnotify
      fswatch # faster lsp
      tectonic # latex
      pplatex # better latex errors
      ddcutil # external monitor brightness
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEI6uHkTas/JiM7YNAGBfXbUSpiVZEM5N7qXv2WSQVMc seabert@Seaberts-MacBook-Pro.local"
    ];
  };

  services.gnome.gnome-keyring.enable = true;

  security.polkit.enable = true;

  security.sudo.extraRules = [
    {
      users = [ "seabert" ];
      commands = [
	{
	  command = "ALL";
	  options = [ "NOPASSWD" ];
	}
      ];
    }
  ];

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
      #clipboard
      grim
      slurp
      wl-clipboard
      # background
      feh
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
  # systemd.user.services.ydotoold = {
  #   Unit = {
  #     Description = "An auto-input utility for wayland";
  #     Documentation = [ "man:ydotool(1)" "man:ydotoold(8)" ];
  #   };
  #
  #   Service = {
  #     ExecStart = "/run/current-system/sw/bin/ydotoold --socket-path /tmp/ydotools";
  #   };
  #
  #   Install = {
  #     WantedBy = ["default.target"];
  #   };
  # };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  programs.thunderbird.enable = true;
  programs.firefox.enable = true;

  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  nix.settings = {
    substituters = ["https://wezterm.cachix.org"];
    trusted-public-keys = ["wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
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
    man-pages

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

  environment.localBinInPath = true;

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
