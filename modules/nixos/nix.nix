# Nix toolchain configuration
{ pkgs, ... }:

{
  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = [ "nix-command" "flakes" ];

      substituters = [ "https://niri.cachix.org" "https://cache.nixos.org/" ];
      trusted-public-keys = [
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
      trusted-users = [ "root" "gavin" ];
    };

    # package = pkgs.lixPackageSets.stable.lix;
  };
  nixpkgs.config.allowUnfree = true;

  # `nh os switch` / `nh home switch` with nice build output and diffing.
  # `flake` lets you run `nh os switch` without passing the flake path.
  programs.nh = {
    enable = true;
    flake = "/home/gavin/Dev/nixfiles";
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
  };

  # Run unpatched dynamically linked binaries (e.g. downloaded toolchains,
  # vscode server, pip wheels) by providing a shim ld.so and library path.
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
      curl
      icu
      libxml2
      libxcrypt-legacy
    ];
  };

}
