# hyprland.nix
{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    # package = pkgs.hyprland; # Or your preferred Hyprland package

    # For Hyprland plugins, if you use any:
    # plugins = [
    #   # example hyprsomePlugin
    # ];

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

      # MY PROGRAMS (Variables)
      # These are typically referenced directly in binds or exec-once
      # We'll define them here for clarity or use them directly below
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
        # "starship" # Starship is a shell prompt, usually not started with exec-once here unless it's a specific daemon.
                       # It's typically initialized in your shell's config (e.g., .bashrc, .zshrc).
        "pywal" # Assuming pywal is a daemon or setup script. If it's 'wal -i' then it's handled below.
        "wal -i" # If this is meant to run once to set a wallpaper based on an image.
                 # Consider how often you want this to run. If it's on every login, this is fine.
                 # If 'wal -i' needs an image path, ensure it's correctly specified or handled by your pywal setup.
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
        shadow = { # This is a custom sub-section, Hyprland usually expects shadow_range, shadow_render_power etc. directly under decoration
                    # We will adapt it if direct mapping is not available in Home Manager or use extraConfig.
                    # For now, let's assume direct mapping or that you will use extraConfig for non-standard nesting.
                    # The standard way in hyprland.conf is:
                    # shadow_range = 15
                    # shadow_render_power = 5
                    # shadow_color = rgba(1a1a1aee)
                    # So we'll try this:
          enable = true; # This is not a standard Hyprland option under decoration.shadow, but blur.enabled is. Assuming you mean 'drop_shadow = yes' (or it's a plugin feature)
                         # Standard options are: drop_shadow, shadow_ignore_window, shadow_offset, shadow_range, shadow_render_power, shadow_scale, col.shadow, col.shadow_inactive
          shadow_range = 15;
          shadow_render_power = 5;
          "col.shadow" = "rgba(1a1a1aee)"; # Assuming this is for active shadow
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 5;
          new_optimizations = true;
          vibrancy = 0.1696;
          xray = false;
          popups = true; # Note: `blur_popups` might be the new name depending on Hyprland version.
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
        sensitivity = 0; # -1.0 - 1.0
        touchpad = {
          natural_scroll = false;
        };
      };

      gestures = {
        workspace_swipe = false;
      };

      # Per-device config
      # In Home Manager, this is often done with `extraConfig` or by defining device blocks if the module supports it directly.
      # The Hyprland module typically expects `device:<name>` as a top-level key or within an `input` block extension.
      # Let's use extraConfig for this to be safe, as direct device block support can vary.
      # A more direct way if supported by the module structure would be:
      # device = {
      #   "razer-deathadder-v3-hyperspeed" = { # This structure might not be correct.
      #     sensitivity = 0;
      #   };
      # };
      # Using extraConfig for precise control:
    };
    extraConfig = ''
      device {
        name = razer-deathadder-v3-hyperspeed
        sensitivity = 0
      }

      # WOFI & WAYBAR & SWAYNC BLUR
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

      # Window rules from your original config if not covered by specific options
      windowrulev2 = suppressevent maximize, class:.*
      windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
    '';

    # KEYBINDINGS
    # Variables are defined above or used directly
    binds = [
      # Programs
      "SUPER, Z, exec, alacritty"
      "SUPER, Q, killactive,"
      "SUPER, M, exit,"
      "SUPER, E, exec, thunar"
      "SUPER, F, togglefloating,"
      "SUPER, SPACE, exec, wofi --show drun"
      "SUPER, P, pseudo,"
      "SUPER, J, togglesplit,"
      "SUPER, B, exec, firefox"
      "SUPER, N, exec, obsidian"
      "SUPER, MINUS, exec, hyprshot -m window"
      "SUPER, EQUAL, exec, hyprshot -m region"
      "SUPER_SHIFT, DELETE, exec, hyprlock"
      # Note: The nixRebuild command uses sudo. Ensure your user has appropriate sudo permissions without a password for this command,
      # or you'll be prompted for a password in a terminal that might not be obvious.
      # Consider alternatives like a polkit rule or running it from a terminal you explicitly open.
      "SUPER_SHIFT, R, exec, alacritty --hold -e \"sudo nixos-rebuild switch --flake /etc/nixos\""

      # Move focus
      "SUPER, left, movefocus, l"
      "SUPER, right, movefocus, r"
      "SUPER, up, movefocus, u"
      "SUPER, down, movefocus, d"

      # Switch workspaces
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, TAB, workspace, e+1" # Your TODO item

      # Move active window to workspace
      "SUPER_SHIFT, 1, movetoworkspace, 1"
      "SUPER_SHIFT, 2, movetoworkspace, 2"
      "SUPER_SHIFT, 3, movetoworkspace, 3"
      "SUPER_SHIFT, 4, movetoworkspace, 4"
      "SUPER_SHIFT, 5, movetoworkspace, 5"

      # Special workspace
      "SUPER, S, togglespecialworkspace, magic"
      "SUPER_SHIFT, S, movetoworkspace, special:magic"

      # Scroll through workspaces
      "SUPER, mouse_down, workspace, e+1"
      "SUPER, mouse_up, workspace, e-1"
    ];

    # Move/resize windows
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    # Laptop multimedia keys (bindel and bindl)
    # These typically go into extraConfig or as direct bind lines if the module doesn't differentiate them.
    # Home Manager's Hyprland module usually just has `binds` for all types.
    # So we add them to the `binds` list, prefixing with ", " for unbound keys if necessary.

    # We will add these to the `binds` list but ensure the format is correct.
    # The Hyprland module expects "MOD, KEY, DISPATCHER, PARAMS"
    # For keys like XF86AudioRaiseVolume, the MOD is empty.
    extraConfigBinds = ''
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

    # Combine extraConfig parts
    extraConfig = (builtins.readFile ./hyprland-extra.conf) + "\n" + config.wayland.windowManager.hyprland.extraConfigBinds;
    # You would create a file named hyprland-extra.conf in the same directory as this nix file
    # and put the device and layerrule/windowrule content there.
    # Or, embed it directly like this:
    # extraConfig = ''
    #   device {
    #     name = razer-deathadder-v3-hyperspeed
    #     sensitivity = 0
    #   }
    #
    #   # WOFI & WAYBAR CUSTOMIZATION
    #   layerrule = blur, wofi
    #   # ... rest of layer rules ...
    #
    #   # Window rules
    #   windowrulev2 = suppressevent maximize, class:.*
    #   # ... rest of window rules ...
    #
    #   # Multimedia Binds
    #   bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    #   # ... rest of multimedia binds ...
    # '';

    # WINDOWS AND WORKSPACES rules are often better in extraConfig for raw format
    # unless the module has specific options for them.
    # windowRule = [ ]; # Example for specific window rule option in HM
    # workspaceRule = [ ]; # Example for specific workspace rule option in HM
    # The `windowrulev2` lines are added to extraConfig above.
  };

  # If pywal needs to generate files that Hyprland or other services use,
  # you might want to ensure it runs correctly. Sometimes this involves xdg.configFile.
  # For example, if pywal generates a colors.conf for Hyprland:
  # xdg.configFile."hypr/colors.conf".source = ./path-to-your-wal-generated-colors.conf;
  # Or more dynamically if pywal updates it:
  # xdg.configFile."hypr/colors.conf".text = builtins.readFile "${config.home.homeDirectory}/.cache/wal/colors-hyprland.conf"; # Adjust path as needed
}
