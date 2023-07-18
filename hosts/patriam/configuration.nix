{ config, pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    config = {
        system.stateVersion = "23.11";

        networking = {
            hostName = "patriam";
            networkmanager.enable = true;
        };

        time.timeZone = "America/Los_Angeles";

        i18n.defaultLocale = "en_US.UTF-8";

        boot.loader = {
            systemd-boot = {
                enable = true;
                configurationLimit = 10;
                editor = false;
            };
            timeout = 5;
        };

        nixpkgs.config.allowUnfree = true;

        monitorConfig = ''
            monitor = HDMI-A-1, 1920x1080@60, 0x180, 1
            monitor = DP-1, 1920x1080@60, 4480x1260, 1          
            monitor = DP-2, 2560x1440@144, 1920x0, 1
            monitor = DP-3, 1920x1080@60, 4480x180, 1

            workspace = HDMI-A-1, 1
            workspace = DP-2, 2
            workspace = DP-3, 3
        '';
    };
}