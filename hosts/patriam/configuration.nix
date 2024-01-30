{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  config = {
    networking = {
      networkmanager.enable = true;
    };

    time.timeZone = "America/Los_Angeles";

    i18n.defaultLocale = "en_US.UTF-8";

    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
    hardware.opengl.enable = true;

    boot.loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

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
        id = 0;
      }
      {
        output = "DP-2";
        dimensions = {
          x = 1920;
          y = 1080;
        };
        refreshRate = 60;
        offset = {
          x = 4480;
          y = 1260;
        };
        scale = 1;
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
        id = 3;
      }
    ];
  };
}
