{ config, pkgs, ... }:

{
   config = {
        wayland.windowManager.hyprland = {
            enable = true;
            recommendedEnvironment = true;

            extraConfig = ''
                exec-once = ${pkgs.swww}/bin/swww init
                exec-once = ${pkgs.swayidle}/bin/swayidle timeout 600 "${pkgs.swaylock-effects}/bin/swaylock -fF --screenshot --effect-blur 4x4 & systemctl suspend"
                exec-once = ${pkgs.nushell}/bin/nu /home/gavin/.config/eww/scripts/launch.nu
            
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

                    border_size = 3

                    col.active_border = rgba(E15197FF) rgba(FE7B72FF) 45deg
                    col.inactive_border = rgba(4D5652FF)

                    layout = dwindle
                }

                dwindle {
                    pseudotile = true
                    preserve_split = true
                }

                decoration {
                    rounding = 7.5
                    
                    blur = yes
                    blur_size = 3
                    blur_passes = 1

                    drop_shadow = yes
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

                $mainMod = SUPER

                bind = $mainMod SHIFT, Q, killactive 
                bind = $mainMod SHIFT, E, exit

                bind = $mainMod, Return, exec, alacritty
                bind = $mainMod, D, exec, fuzzel

                bindm = $mainMod, mouse:272, movewindow
                bindm = $mainMod, mouse:273, resizewindow

                bind = $mainMod, S, togglesplit,
                bind = $mainMod, V, togglefloating,
                bind = $mainMod, F, togglefullscreen,

                bind = , XF86AudioMute, exec, pamixer --toggle-mute
                bind = , XF86AudioRaiseVolume, exec, pamixer -i 5
                bind = , XF86AudioLowerVolume, exec, pamixer -d 5

                bind = $mainMod, 1, workspace, 1
                bind = $mainMod, 2, workspace, 2
                bind = $mainMod, 3, workspace, 3
                bind = $mainMod, 4, workspace, 4
                bind = $mainMod, 5, workspace, 5
                bind = $mainMod, 6, workspace, 6
                bind = $mainMod, 7, workspace, 7
                bind = $mainMod, 8, workspace, 8
                bind = $mainMod, 9, workspace, 9
                bind = $mainMod, 0, workspace, 10

                bind = $mainMod SHIFT, 1, movetoworkspace, 1
                bind = $mainMod SHIFT, 2, movetoworkspace, 2
                bind = $mainMod SHIFT, 3, movetoworkspace, 3
                bind = $mainMod SHIFT, 4, movetoworkspace, 4
                bind = $mainMod SHIFT, 5, movetoworkspace, 5
                bind = $mainMod SHIFT, 6, movetoworkspace, 6
                bind = $mainMod SHIFT, 7, movetoworkspace, 7
                bind = $mainMod SHIFT, 8, movetoworkspace, 8
                bind = $mainMod SHIFT, 9, movetoworkspace, 9
                bind = $mainMod SHIFT, 0, movetoworkspace, 10

                bind = $mainMod, J, movefocus, l
                bind = $mainMod, L, movefocus, r
                bind = $mainMod, I, movefocus, u
                bind = $mainMod, K, movefocus, d
            '';
        };
    };
}