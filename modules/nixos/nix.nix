# Nix toolchain configuration
{ ... }:

{
  nix =
    # flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    {
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";

        substituters = ["https://niri.cachix.org"];
        trusted-public-keys = ["niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="];

        # Opinionated: disable global registry
        # flake-registry = "";
        # Workaround for https://github.com/NixOS/nix/issues/9574
        # nix-path = config.nix.nixPath;
      };
      # Opinionated: disable channels
      # channel.enable = false;

      # Opinionated: make flake registry and nix path match flake inputs
      # registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
      # nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };
  nixpkgs.config.allowUnfree = true;
}
