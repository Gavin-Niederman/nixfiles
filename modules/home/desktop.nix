{ config, pkgs, ... }:
{
    config = {
        programs.firefox.enable = true;
        programs.fuzzel.enable = true;
        programs.alacritty.enable = true;

        services.easyeffects.enable = true;

        fonts.fontconfig.enable = true;

        programs.eww = {
            enable = true;
            package = pkgs.eww-wayland;
            configDir = ./eww;
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

        home.stateVersion = "23.11";
    };
}