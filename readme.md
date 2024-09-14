# Nixfiles

My personal NixOS configuration!

This setup is using the Niri Wayland compositor.
All of my widgets are written with AGS.

## Organization

This configuration is split into three main folders:
- hosts: Host specific NixOS configuration. This includes hardware configuration as well as confiruration for my different hosts' usecases.
- modules: Shared configuration between all hosts. This folder is split into two more subfolders:
  - home-manager: Home manager configuration.
  - nixos: NixOS configuration
- pkgs: Derivations for programs that I want to use, but aren't in nixpkgs or any flakes.

For an explanation of every module itself, look at the short descriptions in every `default.nix`.