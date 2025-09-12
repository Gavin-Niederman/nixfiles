# Nix toolchain configuration
{ pkgs, ... }:

{
  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";

      substituters = [ "https://niri.cachix.org" "https://cache.garnix.io" "https://cache.nixos.org/" ];
      trusted-public-keys = [
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      trusted-users = [ "root" "gavin" ];
    };

    package = pkgs.lixPackageSets.stable.lix;
  };
  nixpkgs.config.allowUnfree = true;

}
