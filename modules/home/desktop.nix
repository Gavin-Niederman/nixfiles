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

        home.file.".config/electron-flags.conf".text =''
            enable-features=UseOzonePlatform
            ozone-platform=wayland
        '';

        home.packages = [ pkgs.eww-wayland ];

        home.stateVersion = "23.11";
    };
}