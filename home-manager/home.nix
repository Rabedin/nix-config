# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default
    inputs.ags.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ./hyprland.nix
    ./browsers.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

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
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "red";
    homeDirectory = "/home/red";
    packages = with pkgs; [
      firefox-bin
      neovim
      ripgrep
      gnumake
      discord
      ferium
      # minecraft
      grimblast
      wl-clipboard
      # prismlauncher
      prismlauncher-unwrapped
      # obs-studio
      # osu-lazer-bin
      spotify
      ranger
      qbittorrent
      # unstable.vmware-workstation
      vmfs-tools
      liquidctl
      corectrl
      htop
      btop
      monero-gui
      xmrig
      p2pool
      scanmem
      glxinfo
      protonvpn-gui
      openrgb
      wootility
      freecad
      graphviz
      xfce.thunar
      pavucontrol
      wofi
      # waybar
      freshfetch
      tmux
      amdgpu_top
      sysbench
      geekbench
      cava
      killall
      lact
      obsidian
      rustup
      lutris
      wine
      wine-wayland
      swww
      waypaper
      eww
      swaybg
      pokemonsay
      fortune
      gcc
      pkg-config
      gtk3
      pango
      gtk-layer-shell
      libdbusmenu-gtk3
      cairo
      libgcc
      glibc
      socat
      gawk
      jq
      coreutils
      playerctl
      lrzip
      kicad
      unzip
      qmk
      vlc
      davinci-resolve
      shotcut
      flowblade
      lightworks
      openshot-qt
      python3
      plasticity
      brave
      via
      vial
      qemu
      # virt-manager
      rpcs3
      bottles
      godot_4
      blender
      openjdk17-bootstrap
      r2modman
      lf
      docker
      python312Packages.diffusers
      python312Packages.pip
      audacity
      p7zip
      vscode-langservers-extracted
      packwiz
      # ollama-rocm
    ];
  };

  # Allowing some insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # Stuff for virt-manager
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  # # GTK
  gtk = {
    enable = true;
    theme = {
      package = pkgs.catppuccin-gtk;
      name = "Catppuccin-mocha";
    };
  };

  # # Qt
  # qt = {
  #   enable = true;
  #   style = {
  #     package = pkgs.catppuccin-qt5ct;
  #     name = "catppuccin-mocha";
  #   };
  # };
  #
  # OBS
  programs = {
    obs-studio = {
      enable = true;
      plugins = [
        pkgs.obs-studio-plugins.wlrobs
        pkgs.obs-studio-plugins.obs-vaapi
        pkgs.obs-studio-plugins.obs-vkcapture
      ];
    };

    kitty = {
      enable = true;
      settings = {
        # Theming
        include = "/home/red/.config/kitty/current-theme.conf";
        background_opacity = "0.95";

        # Font
        font_size = 12;
        font_family = "Iosevka nerd font";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
      };
    };

    ags = {
      enable = true;
      configDir = ./configs/ags;
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };

    wofi = {
      enable = true;
      style = ''
        * {
          font-family: Iosevka nerd font;
          color: #cdd6f4;
        }

        window {
          background-color: #1e1e2e;
          border-style: double;
          border-width: 4px;
          border-color: #585b70;
          padding: 8px;
          border-radius: 4px;
        }

        scrolledwindow {
          padding: 8px;
        }

        flowboxchild {
          background-color: #313244;
          margin-top: 1px;
          margin-bottom: 1px;
        }

        entry {
          background-color: #1e1e2e;
          border-style: double;
          border-width: 4px;
          border-color: #fab387;
          border-radius: 4px;
        }
      '';
    };

    zsh = {
      enable = true;
      initExtra = "fortune | pokemonsay \n";
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
      };
    };

    git = {
      # enable = true;
      userName = "Redwanul Abedin";
      userEmail = "chromeplated@protonmail.com";
      aliases = {
        cm = "commit";
        co = "checkout";
      };
    };

  };


  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
