{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-intel-core-ultra-series3
  ];

  networking.hostName = "striata";

  # Load the GPU driver in the initrd so plymouth starts on it straight away.
  boot.initrd.kernelModules = [ "xe" ];

  my.gnome.enable = true;
  my.niri.enable = true;
  my.steam.enable = true;

  system.stateVersion = "26.11";
}
