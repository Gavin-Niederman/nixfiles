{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.niri.nixosModules.niri ];

  options.my.niri.enable = lib.mkEnableOption "the niri compositor";

  config = {
    # Use nixpkgs' niri: it comes from cache.nixos.org and is built against the
    # system's mesa, so the third-party niri-flake cache isn't needed.
    niri-flake.cache.enable = false;
    programs.niri.package = pkgs.niri;

    programs.niri.enable = config.my.niri.enable;
  };
}
