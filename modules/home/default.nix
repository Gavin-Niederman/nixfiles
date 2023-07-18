{ config, pkgs, ... }:

{
    imports = [
        ./hyprland.nix
        ./development.nix
        ./editor.nix
        ./desktop.nix
        ./shell.nix
    ];
}