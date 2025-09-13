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

    programs.steam.enable = true;

    time.timeZone = "America/Los_Angeles";
    # This fixes a bug where windows will default to GMT
    time.hardwareClockInLocalTime = true;

    i18n.defaultLocale = "en_US.UTF-8";

    hardware.graphics.enable = true; 
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = false;
      # This driver version stops my pc from hanging during startup
      package = config.boot.kernelPackages.nvidiaPackages.legacy_535;
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
