{ config, pkgs, lib, ... }:
    with lib;
    let
        cfg = config.gavin.desktop-env;
    in
    {
        options.gavin.desktop-env = {
            gnome = {
                enable = mkOption {
                    type = types.bool;
                    default = false;
                    description = "Enable GNOME de";
                };
            };
            kde = {
                enable = mkOption {
                    type = types.bool;
                    default = false;
                    description = "Enable KDE Plasma de";
                };
            };
        };
        config = {
            services.xserver = {
                displayManager.gdm.enable = cfg.gnome.enable;
                desktopManager.gnome.enable = cfg.gnome.enable;
                displayManager.sddm.enable = cfg.kde.enable;
                desktopManager.plasma5.enable = cfg.kde.enable;
            };
        };
    }