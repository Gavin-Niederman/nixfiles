{ config, pkgs, lib, ... }:
{
    users.users.gavin = {
        isNormalUser = true;
        createHome = true;
        description = "Gavin";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.nushell;
    };

    security.sudo.wheelNeedsPassword = false;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
}