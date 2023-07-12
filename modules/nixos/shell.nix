{ config, pkgs, lib, ... }:
{
    config = {
        environment.systemPackages = with pkgs; [
            nushell
        ];
        programs.starship.enable = true;
    };
}