{ pkgs, config, ... }:

{
  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      plugins = pkgs.hyprlandPlugins;
      settings = {
        exec-once = [
          "${pkgs.waypaper}/bin/waypaper --restore"
          "${pkgs.ags}/bin/ags"
          "${pkgs.swayosd}/bin/swayosd-server"
        ];

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
          "$mod, ${toString (if x == 10 then 0 else x)}, split-workspace, ${
            toString x
          }"
          "$mod SHIFT, ${
            toString (if x == 10 then 0 else x)
          }, split-movetoworkspace, ${toString x}"
        ]) 11) ++ [
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
          "$mod, S, togglesplit,"
          "$mod, V, togglefloating,"
          "$mod, F, fullscreen,"
          "$mod, U, exec, ${pkgs.firefox}/bin/firefox"
          "$mod, C, exec, ${pkgs.vscode}/bin/code"

          "$mod SHIFT, Q, killactive"
          "$mod SHIFT, E, exit"

          "$mod, RETURN, exec, ${pkgs.wezterm}/bin/wezterm"
          "$mod, D, exec, ${pkgs.fuzzel}/bin/fuzzel"
          ", 107, exec, ${pkgs.grimblast}/bin/grimblast copy area"

          ", XF86AudioMute, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume mute-toggle"
        ];
        bindilt = [
          ", XF86PowerOff, exec, pidof wlogout || ${pkgs.wlogout}/bin/wlogout"
        ];
        binde = [
          ", XF86AudioRaiseVolume, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume 5"
          ", XF86AudioLowerVolume, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume -5"
          ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s +5%"
          ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 5%-"
        ];
        bindm =
          [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];
      };
    };

    programs.hyprlock = {
      enable = true;
      general = { grace = 3; };
      input-fields = [{
        placeholder_text = "<i>Enter password...</i>";
        outline_thickness = 0;
      }];
      backgrounds = [{
        path = "${config.home.homeDirectory}/backgrounds/pink_forest.png";
      }];
    };

    services.hypridle = let
      make-cmd = { action, cmd }:
        (pkgs.writeScriptBin "idle-checked-${action}" ''
          #!${pkgs.nushell}/bin/nu
          if (${pkgs.coreutils}/bin/cat ${config.home.homeDirectory}/.config/idle/idle_enable | into bool) {
              ${cmd}
          } else {
              error make {
                  msg: "idle is disabled"
              }
          }
        '');

    in {
      lockCmd =
        "${pkgs.procps}/bin/pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
      beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
      afterSleepCmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";

      listeners = [
        {
          # 5 minutes
          timeout = 300;
          onTimeout = "${
              make-cmd {
                action = "notify";
                cmd =
                  "${pkgs.libnotify}/bin/notify-send 'Idle' 'You have been idle for 5 minutes'";
              }
            }/bin/idle-checked-notify";
        }
        {
          # 10 minutes
          timeout = 600;
          onTimeout = "${
              make-cmd {
                action = "lock";
                cmd = "${pkgs.systemd}/bin/loginctl lock-session";
              }
            }/bin/idle-checked-lock";
        }
        {
          # 13 minutes
          timeout = 780;
          onTimeout = "${
              make-cmd {
                action = "screen-off";
                cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
              }
            }/bin/idle-checked-screen-off";
          onResume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
        {
          # 25 minutes
          timeout = 1500;
          onTimeout = "${
              make-cmd {
                action = "suspend";
                cmd = "${pkgs.systemd}/bin/systemctl suspend";
              }
            }/bin/idle-checked-suspend";
        }
      ];
    };
  };
}
