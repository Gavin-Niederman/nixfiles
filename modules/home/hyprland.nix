{ config, pkgs, ... }:

{
  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      recommendedEnvironment = true;
      systemdIntegration = true;

      plugins = [ pkgs.hyprlandPlugins.split-monitor-workspaces ];

      extraConfig = ''
        exec-once = ${pkgs.swww}/bin/swww init
        exec-once = ${pkgs.swayidle}/bin/swayidle timeout 600 "${pkgs.swaylock-effects}/bin/swaylock -fF --screenshot --effect-blur 4x4 & systemctl suspend"
        # exec-once = ${pkgs.nushell}/bin/nu /home/gavin/.config/eww/scripts/launch.nu
        exec-once = ${pkgs.ags}/bin/ags

        env = XCURSOR_SIZE, 32

        env = MOZ_ENABLE_WAYLAND, 1
        env = NIXOS_OZONE_WL, 1
        env = XDG_CURRENT_DESKTOP, Hyprland
        env = XDG_SESSION_TYPE, wayland
        env = XDG_SESSION_DESKTOP, Hyprland
        env = QT_QPA_PLATFORM, wayland;xcb
        env = GDK_BACKEND, wayland,x11
        env = SDL_VIDEODRIVER, wayland
        env = CLUTTER_BACKEND, wayland
        env = GTK_IM_MODULE, fcitx
        env = QT_IM_MODULE, fcitx
        env = XMODIFIERS, @im=fcitx

        input {
            kb_layout = us

            follow_mouse = 1
        }

        misc {
            disable_hyprland_logo = true
            disable_splash_rendering = true
        }

        general {
            gaps_in = 8
            gaps_out = 15

            border_size = 0

            # col.active_border = rgba(E15197FF) rgba(FE7B72FF) 45deg
            # col.inactive_border = rgba(4D5652FF)

            layout = dwindle
        }

        dwindle {
            pseudotile = true
            preserve_split = true
        }

        decoration {
            rounding = 7
            multisample_edges = yes

            # blur {
            #     size = 3
            #     passes = 1
            # }

            drop_shadow = no
            shadow_range = 10
            shadow_render_power = 3
        }

        animations {
            enabled = yes

            bezier = speedUpOvershot, 0.35, 0, 0.15, 1.15
            bezier = overshot, 0, 0.34, 0.75, 1.10

            animation = windows, 1, 3, speedUpOvershot
            animation = windowsOut, 1, 3, default, popin 80%
            animation = border, 1, 8, default
            animation = borderangle, 1, 3, default
            animation = fade, 1, 7, default
            animation = workspaces, 1, 7, overshot
        }

        windowrulev2 = center, class:(code),floating:1

        $mainMod = SUPER

        bind = $mainMod SHIFT, Q, killactive 
        bind = $mainMod SHIFT, E, exit

        bind = $mainMod, Return, exec, wezterm
        bind = $mainMod, D, exec, fuzzel

        bind = , 107, exec, grimblast copy area

        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

        bind = $mainMod, S, togglesplit,
        bind = $mainMod, V, togglefloating,
        bind = $mainMod, F, fullscreen,

        bind = , XF86AudioMute, exec, pamixer --toggle-mute
        bind = , XF86AudioRaiseVolume, exec, pamixer -i 5
        bind = , XF86AudioLowerVolume, exec, pamixer -d 5

        bind = $mainMod, 1, split-workspace, 1
        bind = $mainMod, 2, split-workspace, 2
        bind = $mainMod, 3, split-workspace, 3
        bind = $mainMod, 4, split-workspace, 4
        bind = $mainMod, 5, split-workspace, 5
        bind = $mainMod, 6, split-workspace, 6
        bind = $mainMod, 7, split-workspace, 7
        bind = $mainMod, 8, split-workspace, 8
        bind = $mainMod, 9, split-workspace, 9
        bind = $mainMod, 0, split-workspace, 10

        bind = $mainMod SHIFT, 1, split-movetoworkspace, 1
        bind = $mainMod SHIFT, 2, split-movetoworkspace, 2
        bind = $mainMod SHIFT, 3, split-movetoworkspace, 3
        bind = $mainMod SHIFT, 4, split-movetoworkspace, 4
        bind = $mainMod SHIFT, 5, split-movetoworkspace, 5
        bind = $mainMod SHIFT, 6, split-movetoworkspace, 6
        bind = $mainMod SHIFT, 7, split-movetoworkspace, 7
        bind = $mainMod SHIFT, 8, split-movetoworkspace, 8
        bind = $mainMod SHIFT, 9, split-movetoworkspace, 9
        bind = $mainMod SHIFT, 0, split-movetoworkspace, 10

        bind = $mainMod, J, movefocus, l
        bind = $mainMod, L, movefocus, r
        bind = $mainMod, I, movefocus, u
        bind = $mainMod, K, movefocus, d
      '';
    };
  };
}
