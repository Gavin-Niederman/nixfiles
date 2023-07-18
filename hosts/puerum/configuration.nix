{ config, pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    config = {
        system.stateVersion = "23.11";

        networking = {
            hostName = "peurum";
            networkmanager.enable = true;
        };

        time.timeZone = "America/Los_Angeles";

        i18n.defaultLocale = "en_US.UTF-8";

        boot.loader = {
            efi = {
                canTouchEfiVariables = true;
                efiSysMountPoint = "/boot/efi";
            };
            systemd-boot.enable = true;
        };

        nixpkgs.config.allowUnfree = true;

        monitorConfig = ''
            monitor = eDP-1, 1920x1080@60, 0x0, 1
        '';
    };
}