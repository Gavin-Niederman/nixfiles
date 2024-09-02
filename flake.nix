{
  description = "My personal NixOS configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Niri (a wayland compositor/scrollable wm)
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixneovim = {
      url = "github:nixneovim/nixneovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixneovim, niri, ... }@inputs:
    let
      inherit (self) outputs;

      # Import home-manager and nixos configuration
      home-manager-modules.default = import ./modules/home-manager;
      nixos-modules.default = import ./modules/nixos;

      # Nixpkgs overlays allow us to add custom packages to the nixpkgs set
      overlays = system:
        [
          # Get niri-stable and niri-unstable in pkgs
          niri.overlays.niri
          # Get extra neovim plugins in pkgs
          nixneovim.overlays.default
          (final: prev:
            {
              direnv-vim = final.callPackage ./pkgs/direnv-vim.nix { };
            })
        ];

      # The default modules for all systems.
      # System specific modules are held in ./hosts/<hostname>
      default-modules = [
        nixos-modules.default
        # We do home-manager configuration in the nixos configuration instead of through the cli
        home-manager.nixosModules.home-manager
        
        # Add our home-manager configuration
        { home-manager.sharedModules = [
            # Allow for easy home-manager and nixos configuration of niri
            niri.homeModules.config
            # Declarative neovim config
            nixneovim.nixosModules.default
            home-manager-modules.default
          ];
        }
      ];
    in {
      nixosConfigurations = {
        latia = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/latia/configuration.nix ] ++ default-modules
            ++ [{ nixpkgs.overlays = overlays "x86_64-linux"; }];
          system = "x86_64-linux";
        };
      };
    };
}
