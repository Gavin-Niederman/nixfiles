{ 
  description = "My Nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hypr-contrib.url = "github:hyprwm/contrib";

    ags.url = "github:Aylur/ags";
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };
    # watershot.url = "github:Kirottu/watershot";
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, hyprland, hypr-contrib, split-monitor-workspaces, ags, ... }:
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
                  hyprlandPlugins.split-monitor-workspaces = split-monitor-workspaces.packages.${system}.default;
                  grimblast = hypr-contrib.packages.${system}.grimblast;

                  stable-ovmf-aarch = nixpkgs-stable.legacyPackages.aarch64-linux.OVMFFull;
                  # watershot = watershot.packages.${system}.default;
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
