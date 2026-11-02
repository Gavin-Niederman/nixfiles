{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      wallpaper.default.path = "${./wallpaper/dragons_catppuccin_macchiato.png}";

      theme = {
        mode = "dark";
        source = "custom";
        custom_palette = "CatppuccinMocha";
      };

      bar.default = {
        position = "left";
        # Flush with the screen edge and full height.
        margin_edge = 0;
        margin_ends = 0;
        # Square against the screen edge, curving into the screen on the inner side.
        radius_top_left = 0;
        radius_bottom_left = 0;
        radius_top_right = 12;
        radius_bottom_right = 12;
        concave_edge_corners = true;

        start = [
          "launcher"
          "workspaces"
        ];
        center = [
          "clipboard"
          "caffeine"
          "network"
          "media"
          "bluetooth"
        ];
        end = [
          "tray"
          "notifications"
          "volume"
          "brightness"
          "battery"
          "clock"
          "session"
        ];
      };

      widget = {
        network.show_label = false;
        battery = {
          type = "battery";
          display_mode = "graphic";
        };
      };

      shell.session = {
        grid = true;
        grid_columns = 2;
        # Eight actions fill four rows of two.
        actions = [
          { action = "lock"; }
          { action = "lock_and_suspend"; }
          { action = "suspend"; }
          {
            action = "command";
            label = "Hibernate";
            glyph = "bedtime";
            command = "systemctl hibernate";
          }
          { action = "logout"; }
          { action = "reboot_uefi"; }
          { action = "reboot"; }
          { action = "shutdown"; }
        ];
      };
    };

    # Noctalia's docs don't say which flavor its built-in Catppuccin is. Noctalia
    # 5.4.0 ignores unknown keys, so this must use its format, not the newer one.
    customPalettes.CatppuccinMocha.dark = {
      mPrimary = "#cba6f7";
      mOnPrimary = "#11111b";
      mSecondary = "#89b4fa";
      mOnSecondary = "#11111b";
      mTertiary = "#f5c2e7";
      mOnTertiary = "#11111b";
      mError = "#f38ba8";
      mOnError = "#11111b";
      mSurface = "#1e1e2e";
      mOnSurface = "#cdd6f4";
      mSurfaceVariant = "#313244";
      mOnSurfaceVariant = "#a6adc8";
      mOutline = "#45475a";
      mShadow = "#11111b";
      mHover = "#45475a";
      mOnHover = "#cdd6f4";
      terminal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        cursor = "#f5e0dc";
        cursorText = "#1e1e2e";
        selectionBg = "#585b70";
        selectionFg = "#cdd6f4";
        normal = {
          black = "#45475a";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#bac2de";
        };
        bright = {
          black = "#585b70";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#a6adc8";
        };
      };
    };
  };
}
