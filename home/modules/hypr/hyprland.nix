# hyprland.nix
{ pkgs, config, ... }:

let
  # Anything that is better configured in the original format or doesnt have an option can be inserted via extraConfig
  deviceConfig = ''
    device {
      name = razer-deathadder-v3-hyperspeed
      sensitivity = 0
    }
  '';

  customizationAndRules = ''
    # WOFI & WAYBAR CUSTOMIZATION
    layerrule = blur, wofi
    layerrule = ignorezero, wofi
    layerrule = ignorealpha 0.5, wofi

    layerrule = blur, waybar
    layerrule = ignorezero, waybar
    layerrule = ignorealpha 0.5, waybar

    layerrule = blur, swaync-control-center
    layerrule = blur, swaync-notification-window
    layerrule = ignorezero, swaync-control-center
    layerrule = ignorezero, swaync-notification-window
    layerrule = ignorealpha 0.5, swaync-control-center
    layerrule = ignorealpha 0.5, swaync-notification-window

    # Window rules from your original config
    windowrulev2 = suppressevent maximize, class:.*
    windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
  '';

  multimediaKeybinds = ''
    bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
    bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

    bindl = , XF86AudioNext, exec, playerctl next
    bindl = , XF86AudioPause, exec, playerctl play-pause
    bindl = , XF86AudioPlay, exec, playerctl play-pause
    bindl = , XF86AudioPrev, exec, playerctl previous
  '';

  mouseBinds = ''
    # Mouse bindings (formerly in bindm)
    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow
  '';

in
{
  wayland.windowManager.hyprland = {

    settings = {
      # MONITORS
      monitor = [
        "DP-1, 1920x1080@144, auto-right, 1, transform, 3"
        "DP-2, 2560x1440@240, 0x0, 1"
      ];

      # Workspace linking
      workspace = [
        "1, monitor:DP-2, default:true"
        "2, monitor:DP-2"
        "3, monitor:DP-2"
        "4, monitor:DP-2"
        "5, monitor:DP-2"
        "11, monitor:DP-1, default:true"
        "12, monitor:DP-1"
        "13, monitor:DP-1"
        "14, monitor:DP-1"
        "15, monitor:DP-1"
      ];

      # Variables for Hyprland to interpret
      "$terminal" = "alacritty";
      "$fileManager" = "thunar";
      "$menu" = "wofi --show drun";
      "$browser" = "firefox";
      "$notes" = "obsidian";
      "$screenshotWindow" = "hyprshot -m window";
      "$screenshotRegion" = "hyprshot -m region";
      "$lockscreen" = "hyprlock";
      "$nixRebuild" = "alacritty --hold -e \"sudo nixos-rebuild switch --flake /etc/nixos\"";

      # AUTOSTART
      exec-once = [
        "hyprpaper"
        "swaync"
        "waybar"
        "hypridle"
        "pywal"
        "wal -i"
      ];

      # ENVIRONMENT VARIABLES
      env = [
        "XCURSOR_SIZE,20"
        "HYPRCURSOR_SIZE,20"
      ];

      # LOOK AND FEEL
      general = {
        gaps_in = 1;
        gaps_out = 4;
        border_size = 1;
        "col.active_border" = "rgb(8B8ADF) rgb(B487E1) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 4;
        active_opacity = 0.88;
        inactive_opacity = 0.8;
        fullscreen_opacity = 1;
        drop_shadow = true;
        shadow_range = 15;
        shadow_render_power = 3; # Adjusted to a more typical range (1-4)
        "col.shadow" = "rgba(1a1a1aee)";
        blur = {
          enabled = true;
          size = 3;
          passes = 5;
          new_optimizations = true;
          vibrancy = 0.1696;
          xray = false;
          popups = true;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "fluid, 0.15, 0.85, 0.25, 1"
          "snappy, 0.3, 1, 0.4, 1"
        ];
        animation = [
          "windows, 1, 3, fluid, popin 5%"
          "windowsOut, 1, 2.5, snappy"
          "fade, 1, 4, snappy"
          "workspaces, 1, 1.7, snappy, slide"
          "specialWorkspace, 1, 4, fluid, slidefadevert -35%"
          "layers, 1, 2, snappy, popin 70%"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      # INPUT
      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        force_no_accel = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      gestures = {
        workspace_swipe = false;
      };
    }; # End of 'settings'

    # KEYBINDINGS (regular keyboard binds)
    binds = [
      "SUPER, Z, exec, $terminal"
      "SUPER, Q, killactive,"
      "SUPER, M, exit,"
      "SUPER, E, exec, $fileManager"
      "SUPER, F, togglefloating,"
      "SUPER, SPACE, exec, $menu"
      "SUPER, P, pseudo,"
      "SUPER, J, togglesplit,"
      "SUPER, B, exec, $browser"
      "SUPER, N, exec, $notes"
      "SUPER, MINUS, exec, $screenshotWindow"
      "SUPER, EQUAL, exec, $screenshotRegion"
      "SUPER_SHIFT, DELETE, exec, $lockscreen"
      "SUPER_SHIFT, R, exec, $nixRebuild"

      "SUPER, left, movefocus, l"
      "SUPER, right, movefocus, r"
      "SUPER, up, movefocus, u"
      "SUPER, down, movefocus, d"

      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, TAB, workspace, e+1"

      "SUPER_SHIFT, 1, movetoworkspace, 1"
      "SUPER_SHIFT, 2, movetoworkspace, 2"
      "SUPER_SHIFT, 3, movetoworkspace, 3"
      "SUPER_SHIFT, 4, movetoworkspace, 4"
      "SUPER_SHIFT, 5, movetoworkspace, 5"

      "SUPER, S, togglespecialworkspace, magic"
      "SUPER_SHIFT, S, movetoworkspace, special:magic"

      "SUPER, mouse_down, workspace, e+1"
      "SUPER, mouse_up, workspace, e-1"
    ];

    # NO 'bindm' option here anymore

    # SINGLE DEFINITION for extraConfig, combining all raw config parts
    extraConfig = ''
      ${deviceConfig}

      ${customizationAndRules}

      ${multimediaKeybinds}

      ${mouseBinds}
    '';

  }; # End of wayland.windowManager.hyprland
}
