{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  config = {
    system.stateVersion = "23.11";

    zramSwap = {
      enable = true;
      algorithm = "lz4";
      memoryPercent = 200;
    };

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

    monitors = [
      {
        output = "DP-1";
        dimensions = {
          x = 2560;
          y = 1440;
        };
        refreshRate = 144;
        offset = {
          x = 1920;
          y = 0;
        };
        scale = 1;
        workspace = 2;
        id = 1;
      }
      {
        output = "HDMI-A-1";
        dimensions = {
          x = 1920;
          y = 1080;
        };
        refreshRate = 60;
        offset = {
          x = 0;
          y = 180;
        };
        scale = 1;
        workspace = 1;
        id = 2;
      }
      {
        output = "DP-3";
        dimensions = {
          x = 1920;
          y = 1080;
        };
        refreshRate = 60;
        offset = {
          x = 4480;
          y = 180;
        };
        scale = 1;
        workspace = 3;
        id = 3;
      }
    ];
  };
}
