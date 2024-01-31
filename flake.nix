{
  description = "My Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixneovim.url = "github:nixneovim/nixneovim";
    ags.url = "github:Aylur/ags";
  };

  outputs =
    { nixpkgs, home-manager, nixneovim, ags, ... }:
    let
      nixosModules.default = import ./modules/nixos;
      homeModules.default = import ./modules/home;

      overlays = system: [
        nixneovim.overlays.default
        (final: prev: { ags = ags.packages.${system}.default; })
      ];

      defaultModules = [
        nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.sharedModules =
            [ homeModules.default nixneovim.nixosModules.default ];
        }
      ];

      setHostName = hostName: [{ networking.hostName = hostName; }];

      host = { system, modules, hostName }:
        nixpkgs.lib.nixosSystem {
          modules = modules ++ defaultModules ++ setHostName hostName
            ++ [{ nixpkgs.overlays = overlays system; }];
          system = system;
        };
    in {
      nixosConfigurations = {
        puerum = host {
          system = "x86_64-linux";
          hostName = "puerum";
          modules = [ ./hosts/puerum/configuration.nix ];
        };
      };
    };
}
