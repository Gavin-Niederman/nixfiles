{
  description = "My Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    nixneovim.url = "github:nixneovim/nixneovim";
    ags.url = "github:Aylur/ags";
  };

  outputs = { nixpkgs, home-manager, hyprland, split-monitor-workspaces
    , nixneovim, ags, ... }:
    let
      nixosModules.default = import ./modules/nixos;
      homeModules.default = import ./modules/home;

      overlays = system: [
        nixneovim.overlays.default
        (final: prev: {
          ags = ags.packages.${system}.default;
          hyprlandPlugins =
            [ split-monitor-workspaces.packages.${system}.default ];
          direnv-vim = final.callPackage ./pkgs/direnv-vim.nix { };
        })
      ];

      defaultModules = [
        nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.sharedModules = [
            homeModules.default
            nixneovim.nixosModules.default
            hyprland.homeManagerModules.default
          ];
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
        patriam = host {
          system = "x86_64-linux";
          hostName = "patriam";
          modules = [ ./hosts/patriam/configuration.nix ];
        };
      };
    };
}
