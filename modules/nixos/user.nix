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

    security.sudo.wheelNeedsPassword = false;
}