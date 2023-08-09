{
  description = "My Nixos configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    ags.url = "github:Aylur/ags";
    watershot.url = "github:Kirottu/watershot";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ags, watershot, ... }:
    let
      nixosModules.default = import ./modules/nixos;
      homeModules.default = import ./modules/home;

      defaultModules = [
        nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.sharedModules =
            [ hyprland.homeManagerModules.default homeModules.default ];
        }
      ];

      system = { system, modules, ... }:
        nixpkgs.lib.nixosSystem {
          modules = modules ++ defaultModules ++ [{
            nixpkgs = {
              overlays = [
                (final: prev: {
                  ags = ags.packages.${system}.default;
                  watershot = watershot.packages.${system}.default;
                })
              ];
            };
          }];
          system = system;
        };
    in rec {
      nixosConfigurations = {
        patriam = system {
          system = "x86_64-linux";
          modules = [ ./hosts/patriam/configuration.nix ];
        };
        puerum = system {
          system = "x86_64-linux";
          modules = [ ./hosts/puerum/configuration.nix ];
        };
      };
    };
}
