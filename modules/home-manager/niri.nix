# Desktop environment/window manager configuration
{ lib, pkgs, config, ... }:

{
  options = {
    programs.niri.extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
    };
  };
  config = {
    home.file."Wallpapers/".source = ./wallpaper;

    home.file.".config/niri/config.kdl".text = ''
      // Extra Config

      ${config.programs.niri.extraConfig}

      // End Extra Config.
      // The rest of this file is default config.

      // fuck if i know
      spawn-at-startup "${pkgs.dbus}/bin/dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP"

      // start ballad
      spawn-at-startup "${pkgs.ballad}/bin/ballad-shell" 

      // enable the swww daemon
      spawn-at-startup "${pkgs.swww}/bin/swww-daemon"
      // Set a cool wallpaper
      spawn-at-startup "${pkgs.swww}/bin/swww" "img" "${config.home.homeDirectory}/Wallpapers/dragons_catppuccin_macchiato.png" "-t" "wipe" "--transition-angle" "45" "--transition-duration" "1" "--transition-fps" "60"

      // Remove horrendous window decorations
      prefer-no-csd

      hotkey-overlay {
        skip-at-startup
      }

      environment {
          XCURSOR_SIZE "36"
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
          // Xwayland support
          DISPLAY ":0"
          _JAVA_AWT_WM_NONREPARENTING "1"
      }

      // Xwayland support
      xwayland-satellite {
        path "${pkgs.xwayland-satellite}/bin/xwayland-satellite"
      }

      cursor {
          xcursor-theme "capitaine-cursors"
          xcursor-size 36
      }

      window-rule {
          geometry-corner-radius 7.5
          clip-to-geometry true
      }

      window-rule {
          match app-id="krita"
          exclude title="^Krita"

          open-floating true
      }

      window-rule {
          match is-floating=true

          shadow {
              on
              softness 20
              spread 1
              offset x=0 y=5
              draw-behind-window true
              color "#00000048"
          }
      }

      // Input device configuration.
      // Find the full list of options on the wiki:
      // https://github.com/YaLTeR/niri/wiki/Configuration:-Input
      input {
          disable-power-key-handling

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

              active-gradient from="#f5a97f" to="#ed8796" angle=45

              inactive-color "#434c5e"
          }

          // Always show neighbor windows
          struts {
              left 32
              right 32
          }
      }

      screenshot-path null

      binds {
          Mod+Shift+Slash { show-hotkey-overlay; }

          Mod+Return { spawn "${pkgs.kitty}/bin/kitty"; }
          Mod+D { spawn "${pkgs.fuzzel}/bin/fuzzel"; }

          //TODO: Add a screen locker to ballad
          // XF86PowerOff { spawn "ags" "-r" "App.openWindow('logout-menu')"; }

          // Example volume keys mappings for PipeWire & WirePlumber.
          // The allow-when-locked=true property makes them work even when the session is locked.
          XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
          XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
          XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
          XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

          XF86MonBrightnessUp  allow-when-locked=true { spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "+10%"; }
          XF86MonBrightnessDown  allow-when-locked=true { spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "10%-"; }

          Mod+Shift+Q { close-window; }

          Mod+H     { focus-column-left; }
          Mod+J     { focus-window-down; }
          Mod+K     { focus-window-up; }
          Mod+L     { focus-column-right; }

          Mod+Shift+H     { move-column-left; }
          Mod+Shift+J     { move-window-down; }
          Mod+Shift+K     { move-window-up; }
          Mod+Shift+L     { move-column-right; }

          Mod+Home { focus-column-first; }
          Mod+End  { focus-column-last; }
          Mod+Ctrl+Home { move-column-to-first; }
          Mod+Ctrl+End  { move-column-to-last; }

          Mod+Ctrl+H     { focus-monitor-left; }
          Mod+Ctrl+J     { focus-monitor-down; }
          Mod+Ctrl+K     { focus-monitor-up; }
          Mod+Ctrl+L     { focus-monitor-right; }

          Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
          Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
          Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
          Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

          Mod+U              { focus-workspace-down; }
          Mod+I              { focus-workspace-up; }
          Mod+Shift+U         { move-column-to-workspace-down; }
          Mod+Shift+I         { move-column-to-workspace-up; }

          Mod+Ctrl+U         { move-workspace-down; }
          Mod+Ctrl+I         { move-workspace-up; }

          Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
          Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
          Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
          Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

          Mod+1 { focus-workspace 1; }
          Mod+2 { focus-workspace 2; }
          Mod+3 { focus-workspace 3; }
          Mod+4 { focus-workspace 4; }
          Mod+5 { focus-workspace 5; }
          Mod+6 { focus-workspace 6; }
          Mod+7 { focus-workspace 7; }
          Mod+8 { focus-workspace 8; }
          Mod+9 { focus-workspace 9; }
          Mod+Shift+1 { move-column-to-workspace 1; }
          Mod+Shift+2 { move-column-to-workspace 2; }
          Mod+Shift+3 { move-column-to-workspace 3; }
          Mod+Shift+4 { move-column-to-workspace 4; }
          Mod+Shift+5 { move-column-to-workspace 5; }
          Mod+Shift+6 { move-column-to-workspace 6; }
          Mod+Shift+7 { move-column-to-workspace 7; }
          Mod+Shift+8 { move-column-to-workspace 8; }
          Mod+Shift+9 { move-column-to-workspace 9; }

          Mod+Comma  { consume-window-into-column; }
          Mod+Period { expel-window-from-column; }

          Mod+V { toggle-window-floating; }
          Mod+Shift+V { switch-focus-between-floating-and-tiling; }

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
  };
}
