
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Hyprland config
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Monitors
      monitor = [
        # Normie display setup
        "DP-3,3440x1440@239.98900,0x0,1"
        "HDMI-A-1,3840x2160@119.88,-200x-2160,1"
        # Chad display setup???
        # "HDMI-A-1,3840x2160@119.88,0x0,1"
        # "DP-3,3440x1440@239.98900,-1440x0,1,transform,3"
        # "DP-3,disable"
      ];

      # Setting up all my workspaces
      workspace = [
        "1,monitor:DP-3,default:true"
        "2,monitor:DP-3,default:false"
        "3,monitor:DP-3,default:false"
        "4,monitor:DP-3,default:false"
        "5,monitor:DP-3,default:false"
        "6,monitor:DP-3,default:false"
        "7,monitor:HDMI-A-1,default:false"
        "8,monitor:HDMI-A-1,default:false"
        "9,monitor:HDMI-A-1,default:false"
        "10,monitor:HDMI-A-1,default:true"
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
        # "sensitivity" = 1; # -1.0 - 1.0, 0 means no modification.
        "force_no_accel" = true;
      };

      general = {
        "gaps_in" = 5;
        "gaps_out" = 20;
        "border_size" = 2;
        "col.active_border" = "rgba(d65d0eee) rgba(af3a03ee) 45deg";
        "col.inactive_border" = "rgba(282828aa)";

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
}
