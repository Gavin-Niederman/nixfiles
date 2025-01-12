# Nixfiles

My personal NixOS configuration!

This setup is using the Niri Wayland compositor.

## Desktop Environment

I use [Ballad](https://github.com/gavin-niederman/ballad) as my DE. Ballad is a custom DE that I'm building from the ground up made for TWMs like Niri.

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