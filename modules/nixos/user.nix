{ pkgs, lib, ... }:

{
  config = {
    users.users.gavin = {
      isNormalUser = true;
      createHome = true;
      initialPassword = "gavin";
      description = "Gavin";
      extraGroups = [
        "networkmanager"
        "wheel"
        "keyd"
        "docker"
        "video"
        "libvirtd"
        "dialout"
      ];
      shell = pkgs.nushell;
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users = lib.attrsets.genAttrs [ "gavin" ] (_: { });
    };
  };
}
