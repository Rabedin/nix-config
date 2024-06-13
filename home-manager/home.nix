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
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
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
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "red";
    homeDirectory = "/home/red";
    packages = with pkgs; [
      firefox-bin
      neofetch
      neovim
      ripgrep
      gnumake
      discord
      zulu17
      ferium
      # minecraft
      grimblast
      wl-clipboard
      # prismlauncher
      prismlauncher-unwrapped
      # obs-studio
      osu-lazer
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
      # uwufetch
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
      opera
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
      zellij
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
      prusa-slicer
      brave
    ];
  };

  # Allowing some insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # OBS
  programs.obs-studio = {
    enable = true;
    plugins = [
      # pkgs.obs-studio-plugins.wlrobs
      pkgs.obs-studio-plugins.obs-vaapi
      pkgs.obs-studio-plugins.obs-vkcapture
    ];
  };

  # ZSH
  programs.zsh = {
    enable = true;
    initExtra = "fortune | pokemonsay \n";
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
    };
  };

  # Git
  programs.git = {
    # enable = true;
    userName = "Redwanul Abedin";
    userEmail = "chromeplated@protonmail.com";
    aliases = {
      cm = "commit";
      co = "checkout";
    };
  };


  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Monitors
      monitor = [
        # Normie display setup
        # "DP-3,3440x1440@239.98900,0x0,1"
        # "HDMI-A-1,3840x2160@60,-3840x0,2"
        # Chad display setup???
        "HDMI-A-1,3840x2160@119.88,0x0,1"
        "DP-3,3440x1440@239.98900,-1440x0,1,transform,3"
        # "DP-3,disable"
      ];

      # Setting up all my workspaces
      workspace = [
        "1,monitor:HDMI-A-1,default:true"
        "2,monitor:HDMI-A-1,default:false"
        "3,monitor:HDMI-A-1,default:false"
        "4,monitor:HDMI-A-1,default:false"
        "5,monitor:HDMI-A-1,default:false"
        "6,monitor:HDMI-A-1,default:false"
        "7,monitor:HDMI-A-1,default:false"
        "8,monitor:HDMI-A-1,default:false"
        "9,monitor:HDMI-A-1,default:false"
        "10,monitor:DP-3,default:true"
      ];

      # Program variables
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$bar" = "eww open bar";
      "$menu" = "wofi --show drun";
      "$wallpaper" = "waypaper --restore";

      # Autostart
      exec-once = [
        "$bar"
        "$wallpaper"
      ];

      # Env variables
      # env = something

      input = {
        "kb_layout" = "us";
        "follow_mouse" = 1;
        "sensitivity" = 1; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        "gaps_in" = 5;
        "gaps_out" = 20;
        "border_size" = 2;
        "col.active_border" = "rgba(fab387ee) rgba(cba6f7ee) 45deg";
        "col.inactive_border" = "rgba(1e1e2eaa)";

        "layout" = "dwindle";

        "allow_tearing" = false;
      };

      decoration = {
          "rounding" = 10;
          blur = {
              "enabled" = true;
              "size" = 3;
              "passes" = 1;
              "vibrancy" = 0.1696;
          };
          "drop_shadow" = true;
          "shadow_range" = 4;
          "shadow_render_power" = 3;
          "col.shadow" = "rgba(11111bee)";
      };

      animations = {
          "enabled" = true;
          "bezier" = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
      };

      dwindle = {
          "pseudotile" = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          "preserve_split" = true; # you probably want this
      };

      master = {
          "new_is_master" = true;
      };

      gestures = {
          "workspace_swipe" = false;
      };

      misc = {
          "force_default_wallpaper" = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
      };


      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # "windowrulev2" = "suppressevent maximize, class:.*"; # You'll probably like this.

      # Keybind variables
      "$mainMod" = "SUPER";
      "$shiftMod" = "SUPER SHIFT";

      # Keybinds
      bind = [
        # Shortcuts and some tiling stuff
        "$shiftMod, return, exec, $terminal"
        "$shiftMod, C, killactive,"
        "$shiftMod, Q, exit,"
        "$shiftMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, J, togglesplit, # dwindle"
        "$shiftMod, S, exec, grimblast --freeze copysave area"
        # Focus moving binds
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        # Example special workspace (scratchpad)
        # "$mainMod, S, togglespecialworkspace, magic"
        # "$mainMod SHIFT, S, movetoworkspace, special:magic"
        # Scroll through existing workspaces with mainMod + scroll
        # "$mainMod, mouse_down, workspace, e+1"
        # "$mainMod, mouse_up, workspace, e-1"
      ];
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
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
