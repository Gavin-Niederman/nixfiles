# Nixfiles

My personal NixOS configuration!

This setup is using the Niri Wayland compositor.

## Widgets

My widgets are made with [AGS]. Some aspects of my widgets are also directly inspired by GNOME or [Aylur's dotfiles](https://github.com/Aylur/dotfiles) (the creator of [AGS])

## Wallpaper

My wallpaper is a recolored version of [this painting](https://www.artstation.com/artwork/QXgxwd) by [宝林本迟](https://www.artstation.com/chibaolin) (Baolin Benchi). It was created using [Lutgen](https://github.com/ozwaldorf/lutgen-rs).
I pretty much never see anyone crediting the artists that made their backgrounds so I thought I should :3
Make sure to check out some more of this guy's stuff because it's honestly incredible.

## Organization

This configuration is split into three main folders:
- hosts: Host specific NixOS configuration. This includes hardware configuration as well as confiruration for my different hosts' usecases.
- modules: Shared configuration between all hosts. This folder is split into two more subfolders:
  - home-manager: Home manager configuration.
  - nixos: NixOS configuration
- pkgs: Derivations for programs that I want to use, but aren't in nixpkgs or any flakes.

For an explanation of every module itself, look at the short descriptions in every `default.nix`.

[AGS]: https://github.com/Aylur/ags