{ config, pkgs, lib, ... }:

{
  imports = [
    ./hyprland.nix
    ./development.nix
    ./editor.nix
    ./desktop.nix
    ./shell.nix
    ./nix.nix
  ];
}
