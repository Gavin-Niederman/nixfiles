{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  config = {
    networking = { networkmanager.enable = true; };

    time.timeZone = "America/Los_Angeles";

    i18n.defaultLocale = "en_US.UTF-8";

    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };

    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

    # Copious amounts of Nvidia fixes
    hardware.opengl = {
      enable = true;
      driSupport = true;
      extraPackages = [ pkgs.vaapiVdpau ];
    };
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
    };
    home-manager.sharedModules = [{
      wayland.windowManager.hyprland.settings.env =
        [ "LIBVA_DRIVER_NAME,nvidia" "WLR_NO_HARDWARE_CURSORS,1" ];
    }];

    # environment.systemPackages = [
    #   (pkgs.cutter.withPlugins (ps: with ps; [ jsdec rz-ghidra sigdb ]))
    #   (pkgs.rizin.withPlugins (ps: with ps; [ jsdec rz-ghidra sigdb ]))
    # ];

    monitors = [
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
        output = "DP-2";
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
        id = 3;
      }
      {
        output = "DP-1";
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
        id = 0;
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
          y = 1260;
        };
        scale = 1;
        id = 1;
      }
    ];
  };
}
