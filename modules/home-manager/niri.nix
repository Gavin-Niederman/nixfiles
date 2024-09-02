# Desktop environment/window manager configuration
{ pkgs, config, ... }:

{
  home.file."Wallpapers/".source = ./wallpaper;

  home.file.".config/niri/config.kdl".text = ''
    // fuck if i know
    spawn-at-startup "${pkgs.dbus}/bin/dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP"
    // enable a cool wallpaper
    spawn-at-startup "${pkgs.swaybg}/bin/swaybg" "-i" "${config.home.homeDirectory}/Wallpapers/dragons_nord.png" "-m" "fill"

    // Remove horrendous window decorations
    prefer-no-csd

    environment {
        XCURSOR_SIZE "42"
        MOZ_ENABLE_WAYLAND "1"
        NIXOS_OZONE_WL "1"
        XDG_SESSION_TYPE "wayland"
        QT_QPA_PLATFORM "wayland;xcb"
        GDK_BACKEND "wayland,x11"
        SDL_VIDEODRIVER "wayland"
        CLUTTER_BACKEND "wayland"
        GTK_IM_MODULE "fcitx"
        QT_IM_MODULE "fcitx"
        XMODIFIERS "@im=fcitx"
    }

    cursor {
        xcursor-theme "capitaine-cursors"
        xcursor-size 48
    }

    window-rule {
        geometry-corner-radius 7.5
        clip-to-geometry true
    }

    // Input device configuration.
    // Find the full list of options on the wiki:
    // https://github.com/YaLTeR/niri/wiki/Configuration:-Input
    input {
        keyboard {
            xkb {
                // You can set rules, model, layout, variant and options.
                // For more information, see xkeyboard-config(7).

                // For example:
                // layout "us,ru"
                // options "grp:win_space_toggle,compose:ralt,ctrl:nocaps"
            }
        }

        // Next sections include libinput settings.
        // Omitting settings disables them, or leaves them at their default values.
        touchpad {
            // off
            tap
            // dwt
            // dwtp
            // accel-speed 0.2
            // accel-profile "flat"
            // scroll-method "two-finger"
            // disabled-on-external-mouse
        }

        mouse {
            // off
            // natural-scroll
            // accel-speed 0.2
            // accel-profile "flat"
            // scroll-method "no-scroll"
        }

        // Focus to windows that are mostly on the same screen
        focus-follows-mouse max-scroll-amount="50%"
    }

    layout {
        // Set gaps around windows in logical pixels.
        gaps 16

        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        // Let the window decide :3
        default-column-width { }

        focus-ring {
            width 4

            active-gradient from="#bf616a" to="#d08770" angle=45

            inactive-color "#434c5e"
        }

        // You can also add a border. It's similar to the focus ring, but always visible.
        border {
            // The settings are the same as for the focus ring.
            // If you enable the border, you probably want to disable the focus ring.
            off

            width 4
            active-color "#ffc87f"
            inactive-color "#505050"

            // active-gradient from="#ffbb66" to="#ffc880" angle=45 relative-to="workspace-view"
            // inactive-gradient from="#505050" to="#808080" angle=45 relative-to="workspace-view"
        }

        // Always show neighbor windows
        struts {
            left 16
            right 16
        }
    }

    screenshot-path null

    binds {
        Mod+Shift+Slash { show-hotkey-overlay; }

        // Suggested binds for running programs: terminal, app launcher, screen locker.
        Mod+Return { spawn "${pkgs.kitty}/bin/kitty"; }
        Mod+D { spawn "${pkgs.fuzzel}/bin/fuzzel"; }

        // Example volume keys mappings for PipeWire & WirePlumber.
        // The allow-when-locked=true property makes them work even when the session is locked.
        XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
        XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

        Mod+Shift+Q { close-window; }

        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }
        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+L     { focus-column-right; }

        Mod+Ctrl+Left  { move-column-left; }
        Mod+Ctrl+Down  { move-window-down; }
        Mod+Ctrl+Up    { move-window-up; }
        Mod+Ctrl+Right { move-column-right; }
        Mod+Ctrl+H     { move-column-left; }
        Mod+Ctrl+J     { move-window-down; }
        Mod+Ctrl+K     { move-window-up; }
        Mod+Ctrl+L     { move-column-right; }

        // Alternative commands that move across workspaces when reaching
        // the first or last window in a column.
        // Mod+J     { focus-window-or-workspace-down; }
        // Mod+K     { focus-window-or-workspace-up; }
        // Mod+Ctrl+J     { move-window-down-or-to-workspace-down; }
        // Mod+Ctrl+K     { move-window-up-or-to-workspace-up; }

        Mod+Home { focus-column-first; }
        Mod+End  { focus-column-last; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End  { move-column-to-last; }

        Mod+Shift+Left  { focus-monitor-left; }
        Mod+Shift+Down  { focus-monitor-down; }
        Mod+Shift+Up    { focus-monitor-up; }
        Mod+Shift+Right { focus-monitor-right; }
        Mod+Shift+H     { focus-monitor-left; }
        Mod+Shift+J     { focus-monitor-down; }
        Mod+Shift+K     { focus-monitor-up; }
        Mod+Shift+L     { focus-monitor-right; }

        Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
        Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

        // Alternatively, there are commands to move just a single window:
        // Mod+Shift+Ctrl+Left  { move-window-to-monitor-left; }
        // ...

        // And you can also move a whole workspace to another monitor:
        // Mod+Shift+Ctrl+Left  { move-workspace-to-monitor-left; }
        // ...

        Mod+Page_Down      { focus-workspace-down; }
        Mod+Page_Up        { focus-workspace-up; }
        Mod+U              { focus-workspace-down; }
        Mod+I              { focus-workspace-up; }
        Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
        Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
        Mod+Ctrl+U         { move-column-to-workspace-down; }
        Mod+Ctrl+I         { move-column-to-workspace-up; }

        Mod+Shift+U         { move-workspace-down; }
        Mod+Shift+I         { move-workspace-up; }

        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

        Mod+WheelScrollRight      { focus-column-right; }
        Mod+WheelScrollLeft       { focus-column-left; }
        Mod+Ctrl+WheelScrollRight { move-column-right; }
        Mod+Ctrl+WheelScrollLeft  { move-column-left; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Ctrl+1 { move-column-to-workspace 1; }
        Mod+Ctrl+2 { move-column-to-workspace 2; }
        Mod+Ctrl+3 { move-column-to-workspace 3; }
        Mod+Ctrl+4 { move-column-to-workspace 4; }
        Mod+Ctrl+5 { move-column-to-workspace 5; }
        Mod+Ctrl+6 { move-column-to-workspace 6; }
        Mod+Ctrl+7 { move-column-to-workspace 7; }
        Mod+Ctrl+8 { move-column-to-workspace 8; }
        Mod+Ctrl+9 { move-column-to-workspace 9; }

        Mod+Comma  { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { reset-window-height; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+C { center-column; }

        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }

        // Finer height adjustments when in column with other windows.
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        Print { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }

        // The quit action will show a confirmation dialog to avoid accidental exits.
        Mod+Shift+E { quit; }
    }
  '';
}
