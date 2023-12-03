{ pkgs, ... }:

{
  config = {
    virtualisation.libvirtd.enable = true;
    environment.systemPackages = with pkgs; [ virt-manager ];
    virtualisation.libvirtd.qemu.ovmf = {
      enable = true;
      packages = with pkgs; [ OVMFFull.fd OVMF-arm.fd ];
    };
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
