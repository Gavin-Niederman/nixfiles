# Bootloader configuration.
# I use GRUB as my bootloader with os-prober to detect other operating systems.
{ ... }:

{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      useOSProber = true;
      device = "nodev";
    };
  };
}