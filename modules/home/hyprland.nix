{ pkgs, ... }:

{
  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      settings = {
        exec-once = [ "${pkgs.swww}/bin/swww init" "${pkgs.ags}/bin/ags" ];

        env = [
          "XCURSOR_SIZE, 42"
          "MOZ_ENABLE_WAYLAND, 1"
          "NIXOS_OZONE_WL, 1"
          "XDG_CURRENT_DESKTOP, Hyprland"
          "XDG_SESSION_TYPE, wayland"
          "XDG_SESSION_DESKTOP, Hyprland"
          "QT_QPA_PLATFORM, wayland;xcb"
          "GDK_BACKEND, wayland,x11"
          "SDL_VIDEODRIVER, wayland"
          "CLUTTER_BACKEND, wayland"
          "GTK_IM_MODULE, fcitx"
          "QT_IM_MODULE, fcitx"
          "XMODIFIERS, @im=fcitx"
        ];

        input = {
          "kb_layout" = "us";
          "follow_mouse" = 1;
        };

        misc = {
          "disable_hyprland_logo" = true;
          "disable_splash_rendering" = true;
        };

        general = {
          "gaps_in" = 8;
          "gaps_out" = 15;

          "border_size" = 0;

          "layout" = "dwindle";
        };

        gestures = {
          "workspace_swipe" = true;
          "workspace_swipe_invert" = true;
          "workspace_swipe_cancel_ratio" = 0.15;
        };

        dwindle = {
          "pseudotile" = true;
          "preserve_split" = true;
        };

        decoration = {
          "rounding" = 7;

          "drop_shadow" = false;
        };

        animations = {
          "enabled" = true;
          bezier = [
            "speedUpOvershot, 0.35, 0, 0.15, 1.15"
            "overshot, 0, 0.34, 0.75, 1.10"
          ];
          animation = [
            "windows, 1, 1.5, speedUpOvershot"
            "windowsOut, 1, 1.5, default, popin 80%"
            "border, 1, 8, default"
            "borderangle, 1, 3, default"
            "fade, 1, 3, default"
            "workspaces, 1, 3, overshot"
          ];
        };

        # Make sure vscode popups are not above the screen.
        "windowrulev2" = "center, class:(code),floating:1";

        "$mod" = "SUPER";
        bind = builtins.concatLists (builtins.genList (x: [
          "$mod, ${toString x}, workspace, ${toString x}"
          "$mod SHIFT, ${toString x}, movetoworkspace, ${toString x}"
        ]) 10) ++ [
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
          "$mod, S, togglesplit,"
          "$mod, V, togglefloating,"
          "$mod, F, fullscreen,"

          "$mod SHIFT, Q, killactive"
          "$mod SHIFT, E, exit"

          "$mod, RETURN, exec, ${pkgs.wezterm}/bin/wezterm"
          "$mod, D, exec, ${pkgs.fuzzel}/bin/fuzzel"
          ", 107, exec, ${pkgs.grimblast}/bin/grimblast copy area"

          ", XF86AudioMute, exec, ${pkgs.swayosd}/bin/swayosd --output-volume mute-toggle"
          ", XF86AudioRaiseVolume, exec, ${pkgs.swayosd}/bin/swayosd --output-volume 5"
          ", XF86AudioLowerVolume, exec, ${pkgs.swayosd}/bin/swayosd --output-volume -5"

          ", XF86MonBrightnessUp, exec, ${pkgs.swayosd}/bin/swayosd --brightness raise"
          ", XF86MonBrightnessDown, exec, ${pkgs.swayosd}/bin/swayosd --brightness lower"
        ];
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
