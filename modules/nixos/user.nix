{ config, pkgs, lib, ... }:
{
    users.users.gavin = {
        isNormalUser = true;
        createHome = true;
        initialPassword = "gavin";
        description = "Gavin";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.nushell;
    };

    users.users.nixosvmtest = {
      isSystemUser = true ;
      initialPassword = "test";
      group = "nixosvmtest";
    };
    users.groups.nixosvmtest = {};

    security.sudo.wheelNeedsPassword = false;
}