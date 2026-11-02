{ inputs, pkgs, ... }:
let
  inherit (inputs.nixpkgs) rev narHash lastModified;

  source = {
    type = "github";
    owner = "NixOS";
    repo = "nixpkgs";
    inherit rev;
  };

  flake = pkgs.writeText "flake.nix" ''
    {
      inputs.nixpkgs.url = "github:NixOS/nixpkgs/${rev}";

      outputs =
        { nixpkgs, ... }:
        nixpkgs
        // {
          legacyPackages = builtins.mapAttrs (
            system: _:
            import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            }
          ) nixpkgs.legacyPackages;
        };
    }
  '';

  # A store path can't have a lock file written to it, so it has to come with one.
  lock = pkgs.writeText "flake.lock" (
    builtins.toJSON {
      version = 7;
      root = "root";
      nodes = {
        root.inputs.nixpkgs = "nixpkgs";
        nixpkgs = {
          original = source;
          locked = source // {
            inherit narHash lastModified;
          };
        };
      };
    }
  );

  # Plain `nix run nixpkgs#foo` can't read allowUnfree from the system config or
  # the environment, so `nixpkgs` points at this wrapper with unfree enabled. It
  # uses the system's nixpkgs revision and keeps all of its other flake outputs.
  unfreeNixpkgs = pkgs.runCommand "nixpkgs-unfree" { } ''
    mkdir $out
    cp ${flake} $out/flake.nix
    cp ${lock} $out/flake.lock
  '';
in
{
  nixpkgs.flake = {
    setFlakeRegistry = false;
    setNixPath = false;
  };

  nix = {
    registry.nixpkgs.to = {
      type = "path";
      path = "${unfreeNixpkgs}";
    };
    # The wrapper has no default.nix, so `nix-shell -p` needs nixpkgs itself.
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };
}
