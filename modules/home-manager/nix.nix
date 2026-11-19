{ ... }:

{
  # nixpkgs.config is inherited from the NixOS configuration (home-manager.useGlobalPkgs).

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
