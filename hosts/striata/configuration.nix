{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-intel-core-ultra-series3
  ];

  networking.hostName = "striata";

  # Load the GPU driver in the initrd so plymouth starts on it straight away.
  boot.initrd.kernelModules = [ "xe" ];

  # The swap partition from hardware-configuration.nix, for resuming from hibernation.
  boot.resumeDevice = "/dev/disk/by-uuid/a639a8a7-9aa2-40bd-87c3-0f8a8b523216";

  my.gnome.enable = true;
  my.niri.enable = true;
  my.steam.enable = true;

  system.stateVersion = "26.11";
}
