# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  networking.hostName = "nixos";

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    kernelModules = [ "v4l2loopback" ];
  };

  # Enable zsh
  programs.zsh.enable = true;

  # Users
  users.users = {
    red = {
      isNormalUser = true;
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEPsausosDB2J33VyLMCooKdnvHklUDwFOsFHhpIeEf5 red@nixos"
      ];
      extraGroups = ["networkmanager" "wheel"];
    };
    minidlna = {
      extraGroups = [ "users" ];
    };
  };

  # opengl shit for obs
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  # Networking
  networking = {
    networkmanager.enable = true;
    # Firewall
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # ssh
        8200 # miniDLNA
        25565 # Minecraft server hosting
        34197 # Factorio LAN server
        38763 # Minecraft LAN temp server
        30010
        3333  # P2Pool stratum server port
        18083 # Something for Monero node?
        18080 # Monero p2p port
        37889 # P2Pool port
        37888 # P2Pool mini port
        51820 # Wireguard
        51821 # Wireguard
      ];
      allowedUDPPorts = [
        22 # ssh
        8200 # miniDLNA
        25565 # Minecraft server hosting
        34197 # Factorio LAN server
        38763 # Minecraft LAN temp server
        30010
        3333  # P2Pool stratum server port
        18083 # Something for Monero node?
        18080 # Monero p2p port
        37889 # P2Pool port
        37888 # P2Pool mini port
        51820 # Wireguard
        51821 # Wireguard
      ];
    };
    enableIPv6 = false;
  };

  # DLNA server
  services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      notify_interval = 60;
      friendly_name = "nixos";
      media_dir = [
        "V, /mnt/NVME2TB/minidlna/"
      ];
    };
  };

  # Time zone
  time.timeZone = "America/Toronto";

  # Locale
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable X11 + gnome
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    firefox
    home-manager
    vim
    kitty
    git
    wget
    dnsmasq
    mesa
    zulu8
    jre8
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];  

  # Udev rules for QMK
  # services.udev.extraRules = builtins.readFile ./qmk-udev;
  # services.udev.packages = [ ../home-manager/qmk_udev ];

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Enable OpenTabletDriver for sweet sweet osu
  hardware.opentabletdriver.enable = true;

  # VMWare
  virtualisation.vmware.host.enable = false;

  services.dnsmasq = {
    enable = true;
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
