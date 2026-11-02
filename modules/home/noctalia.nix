{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      wallpaper.default.path = "${./wallpaper/dragons_catppuccin_macchiato.png}";

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      # The lock animation delays every suspend by its 1.5 second duration.
      lockscreen.transition = [ ];

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

      shell.polkit_agent = true;

      shell.session = {
        grid = true;
        grid_columns = 2;
        # Eight actions fill four rows of two.
        actions = [
          {
            action = "lock";
            shortcut = "z";
          }
          {
            action = "lock_and_suspend";
            shortcut = "s";
          }
          { action = "suspend"; }
          {
            action = "command";
            label = "Hibernate";
            glyph = "zzz";
            command = "systemctl hibernate";
          }
          { action = "logout"; }
          { action = "reboot_uefi"; }
          {
            action = "reboot";
            shortcut = "r";
          }
          {
            action = "shutdown";
            shortcut = "q";
          }
        ];
      };
    };
  };
}
