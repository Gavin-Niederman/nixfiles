{ ... }:

{
  nixpkgs = {
    config = {
      # Allow packages that are not free software without providing NIX_ALLOW_UNFREE=1
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
