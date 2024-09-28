# My personal laptop configuration
# Latia is a genus of bioluminescent freshwater snails, the only one in the world!
# When you mess with them, they will release  cloud of glowing liquid (pretty much  a cooler version of squid ink).
{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  config = {
    networking = {
      networkmanager.enable = true;
      hostName = "latia";
    };

    programs.steam.enable = true;

    time.timeZone = "America/Los_Angeles";
    i18n.defaultLocale = "en_US.UTF-8";

    hardware.graphics.enable = true;

    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };

    boot.loader.efi = { canTouchEfiVariables = true; };
    boot.extraModprobeConfig = ''
      options snd-intel-dspcfg dsp_driver=1
    '';
  };
}
