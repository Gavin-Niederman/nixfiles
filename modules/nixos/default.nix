{ pkgs, lib, config, ... }:

{
  imports = [
    ./desktop.nix
    ./user.nix
    ./nix.nix
    ./development.nix
    ./shell.nix
    ./monitors.nix
  ];
}
