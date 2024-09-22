# My desktop computer configuration
# Noctiluca scintillans is a bioluminescent species of single celled organism.
# It is famous for its ability to make oceans glow blue.
# Example photo: https://scx2.b-cdn.net/gfx/news/2023/historic-red-tide-even.jpg
{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  config = {
    networking = {
      networkmanager.enable = true;
      hostName = "noctiluca";
    };

    time.timeZone = "America/Los_Angeles";
    # This fixes a bug where windows will default to GMT
    time.hardwareClockInLocalTime = true;

    i18n.defaultLocale = "en_US.UTF-8";

    hardware.graphics.enable = true; 
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      # This driver version stops my pc from hanging during startup
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "535.154.05";
        sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
        sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
        openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
        settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
        persistencedSha256 =
          "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";
      };
    };

    hardware.monitors = {
      enable = true;
      outputs = [
        {
          output = "DP-2";
          mode = {
            refreshRate = "143.972";
            size = {
              x = 2560;
              y = 1440;
            };
          };
          position = {
            x = 0;
            y = 0;
          };
        }
        {
          output = "DP-3";
          position = {
            x = 2560;
            y = 0;
          };
          mode = {
            refreshRate = "74.973";
            size = {
              x = 1920;
              y = 1080;
            };
          };
        }
        {
          output = "HDMI-A-1";
          position = {
            x = -1920;
            y = 1440 - 1080;
          };
          mode = {
            refreshRate = "60";
            size = {
              x = 1920;
              y = 1080;
            };
          };
        }
      ];
    };
  };
}
