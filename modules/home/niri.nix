{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.niri.settings = {
    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;
    screenshot.path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
    xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

    input = {
      touchpad = {
        tap = true;
        click-method = "clickfinger";
        natural-scroll = false;
      };
      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "50%";
      };
    };

    # niri only configures VRR per output, and ignores it where unsupported.
    outputs = lib.genAttrs [ "eDP-1" "DP-1" "DP-2" "DP-3" "DP-4" ] (_: {
      variable-refresh-rate = true;
    });

    gestures.hot-corners = {
      top-left = false;
      top-right = false;
      bottom-left = false;
      bottom-right = false;
    };

    layout = {
      gaps = 16;
      center-focused-column = "never";
      default-column-width = { };
      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];
      struts = {
        left = 32;
        right = 32;
      };
      focus-ring = {
        width = 4;
        active.gradient = {
          from = "#f5a97f";
          to = "#ed8796";
          angle = 45;
        };
        inactive.color = "#434c5e";
      };
    };

    window-rules = [
      {
        geometry-corner-radius = {
          top-left = 7.5;
          top-right = 7.5;
          bottom-left = 7.5;
          bottom-right = 7.5;
        };
        clip-to-geometry = true;
      }
      {
        matches = [ { is-floating = true; } ];
        shadow = {
          enable = true;
          softness = 20;
          spread = 1;
          offset = {
            x = 0;
            y = 5;
          };
          draw-behind-window = true;
          color = "#00000048";
        };
      }
    ];

    binds =
      with config.lib.niri.actions;
      let
        # Mod+N focuses workspace N, Mod+Shift+N moves the column there.
        workspaceBinds = lib.mergeAttrsList (
          map (n: {
            "Mod+${toString n}".action = focus-workspace n;
            "Mod+Shift+${toString n}".action.move-column-to-workspace = n;
          }) (lib.range 1 9)
        );
        brightnessctl = lib.getExe pkgs.brightnessctl;
        lockedSpawn = argv: {
          allow-when-locked = true;
          action.spawn = argv;
        };
      in
      workspaceBinds
      // {
        "Mod+Shift+Slash".action = show-hotkey-overlay;
        "Mod+G".action = toggle-overview;

        "Mod+Return".action.spawn = lib.getExe config.programs.ghostty.package;
        "Mod+D".action.spawn = lib.getExe config.programs.fuzzel.package;

        "XF86AudioRaiseVolume" = lockedSpawn [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.1+"
        ];
        "XF86AudioLowerVolume" = lockedSpawn [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.1-"
        ];
        "XF86AudioMute" = lockedSpawn [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SINK@"
          "toggle"
        ];
        "XF86AudioMicMute" = lockedSpawn [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SOURCE@"
          "toggle"
        ];
        "XF86MonBrightnessUp" = lockedSpawn [
          brightnessctl
          "set"
          "+10%"
        ];
        "XF86MonBrightnessDown" = lockedSpawn [
          brightnessctl
          "set"
          "10%-"
        ];

        "Mod+Shift+Q".action = close-window;

        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+L".action = focus-column-right;

        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+J".action = move-window-down;
        "Mod+Shift+K".action = move-window-up;
        "Mod+Shift+L".action = move-column-right;

        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Ctrl+Home".action = move-column-to-first;
        "Mod+Ctrl+End".action = move-column-to-last;

        "Mod+Ctrl+H".action = focus-monitor-left;
        "Mod+Ctrl+J".action = focus-monitor-down;
        "Mod+Ctrl+K".action = focus-monitor-up;
        "Mod+Ctrl+L".action = focus-monitor-right;

        "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;
        "Mod+Shift+U".action = move-column-to-workspace-down;
        "Mod+Shift+I".action = move-column-to-workspace-up;

        "Mod+Ctrl+U".action = move-workspace-down;
        "Mod+Ctrl+I".action = move-workspace-up;

        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action = focus-workspace-down;
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action = focus-workspace-up;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          action = move-column-to-workspace-down;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          action = move-column-to-workspace-up;
        };

        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;

        "Mod+V".action = toggle-window-floating;
        "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = reset-window-height;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+C".action = center-column;

        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        "Print".action.screenshot = [ ];
        "Ctrl+Print".action.screenshot-screen = [ ];
        "Alt+Print".action.screenshot-window = [ ];

        "Mod+Shift+E".action = quit;
      };
  };
}
