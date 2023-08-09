{ config, pkgs, lib, ... }:

{
    config = {
        programs.firefox.enable = true;
        programs.fuzzel.enable = true;
        programs.alacritty.enable = true;

        services.easyeffects.enable = true;

        fonts.fontconfig.enable = true;

        home.file = {
            ".config/eww/scripts".source = ./eww/scripts;
            ".config/eww/widgets".source = ./eww/widgets;
            ".config/eww/eww.scss".source = ./eww/eww.scss;
            ".config/eww/eww.yuck".text = ''
                (include "widgets/widgets.yuck")

                (defwidget bar []
                    (box
                        :class "bg"
                        (box
                            :class "center"
                            :halign "center"
                            :space-evenly false
                            (clock)
                        )
                    )
                )
            '';
        };

        home.file = {
            ".config/ags/style.css".source = ./ags/style.css;
            ".config/ags/config.js".text = ''
            var config = {
                baseIconSize: 18,
                closeWindowDelay: {
                    'window-name': 500, // milliseconds
                },
                exitOnError: false,
                notificationPopupTimeout: 5000, // milliseconds
                stackTraceOnError: false,
                style: '/home/gavin/.config/ags/style.css',
                windows: windows
            };

            const bar = {
                type: 'box',
                children: [clock],
            };

            const clock = {
                type: 'label',
                connections: [[1000, label => label.label = exec('date +%H:%M:%S')]],
            };
            '';
        };

        gtk = {
            enable = true;

            cursorTheme = {
                name = "capitaine-cursors";
                package = pkgs.capitaine-cursors;
            };

            iconTheme = {
                name = "kora";
                package = pkgs.kora-icon-theme;
            };
        };

        home.file.".config/electron-flags.conf".text = ''
            enable-features=UseOzonePlatform
            ozone-platform=wayland
        '';

        home.packages = [ pkgs.eww-wayland ];

        home.stateVersion = "23.11";
    };
}