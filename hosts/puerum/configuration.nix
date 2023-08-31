{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  config = {
    system.stateVersion = "23.11";

    networking = {
      hostName = "puerum";
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

    monitors = [{
      output = "eDP-1";
      dimensions = {
        x = 1920;
        y = 1080;
      };
      refreshRate = 60;
      offset = {
        x = 0;
        y = 0;
      };
      scale = 1;
      id = 0;
    }];
  };
}
