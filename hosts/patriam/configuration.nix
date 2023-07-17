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
    };
}