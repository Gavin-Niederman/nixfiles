# My personal laptop configuration
# Latia is a genus of bioluminescent freshwater snails, the only one in the world!
# When you mess with them, they will release  cloud of glowing liquid (pretty much  a cooler version of squid ink).
{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  config = {
    networking = {
      networkmanager.enable = true;
      hostName = "latia";
    };

    time.timeZone = "America/Los_Angeles";
    i18n.defaultLocale = "en_US.UTF-8";

    # VA-API hardware video decode/encode on the Intel Iris Xe (Tiger Lake)
    # iGPU. intel-media-driver is the modern "iHD" driver; libva-utils gives
    # `vainfo` for checking it works.
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [ intel-media-driver ];
    };
    environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
    environment.systemPackages = with pkgs; [ libva-utils ];

    # Monitor layout. The Kamvas sits physically to the LEFT of the laptop
    # screen, top edges aligned, so it gets negative x and the same y as
    # eDP-1. Pinning this (rather than letting niri auto-arrange) is what
    # makes unplugging the tablet a non-event: niri keeps per-output config
    # for disconnected outputs, parks their windows on eDP-1, and restores
    # them to the exact same geometry on replug -- instead of appending the
    # tablet to the right of the laptop in connection order.
    #
    # Both outputs pin mode AND scale, because `position` is in logical
    # pixels: if niri ever auto-picked a different scale for the Kamvas, its
    # logical width would stop being 1920 and leave a gap (or an overlap, on
    # which niri discards the manual layout entirely) at the seam.
    hardware.monitors = {
      enable = true;
      outputs = [
        {
          # Internal panel. Matched by connector, since it can never move.
          output = "eDP-1";
          mode = {
            size = {
              x = 1920;
              y = 1080;
            };
            refreshRate = "60.049";
          };
          # 1920x1080 / 1.25 = 1536x864 logical.
          scale = 1.25;
          position = {
            x = 0;
            y = 0;
          };
        }
        {
          # Kamvas Pro 16. Matched by make/model/serial rather than
          # "HDMI-A-1" so the layout survives being plugged into a
          # different port.
          output = "PNP(HAT) Kamvas Pro 16 0x01010101";
          mode = {
            size = {
              x = 1920;
              y = 1080;
            };
            refreshRate = "60.000";
          };
          # Unscaled: drawing 1:1 with the pen beats smaller UI.
          scale = 1.0;
          # 1920 logical px wide, so -1920 butts its right edge against
          # eDP-1's left edge with no dead zone for the cursor to cross.
          position = {
            x = -1920;
            y = 0;
          };
        }
      ];
    };

    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Enable = "Source,Sink,Media,Socket";
    };
    home-manager.sharedModules = [{ services.mpris-proxy.enable = true; }];
    services.blueman.enable = true;

    boot.loader.efi = { canTouchEfiVariables = true; };
    boot.extraModprobeConfig = ''
      options snd-intel-dspcfg dsp_driver=1
    '';
  };
}
