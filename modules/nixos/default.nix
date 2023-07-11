{ pkgs, lib, config, ... }:

{
    imports = [
        ./hyprland.nix
        ./user.nix
        ./nix.nix
    ];
}