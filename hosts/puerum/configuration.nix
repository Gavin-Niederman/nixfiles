{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  config = {
    networking = { networkmanager.enable = true; };

    time.timeZone = "America/Los_Angeles";

    i18n.defaultLocale = "en_US.UTF-8";

    hardware.graphics.enable = true;

    boot.loader.efi = { canTouchEfiVariables = true; };

    boot.extraModprobeConfig = ''
      options snd-intel-dspcfg dsp_driver=1
    '';

    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

    monitors = [
      {
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
      }
      {
        output = "HDMI-A-1";
        dimensions = {
          x = 1920;
          y = 1080;
        };
        refreshRate = 60;
        offset = {
          x = 1920;
          y = 0;
        };
        scale = 1;
        id = 1;
      }
    ];

    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };

    home-manager.sharedModules = [{ services.hypridle.enable = true; }];
  };
}
