{
  description = "My personal NixOS configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # A slightly faster Nix implementation
    lix = {
      url =
        "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    # A external rootless xwayland program so that i can run stuff like GIMP
    # I wrote this flake :3
    xwayland-satellite.url = "github:Supreeeme/xwayland-satellite?rev=stylus";

    nixneovim = {
      url = "github:nixneovim/nixneovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My personal DE
    ballad.url = "github:gavin-niederman/ballad";

    # Catpuccin themes
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, lix, home-manager, nixneovim, niri
    , xwayland-satellite, ballad, catppuccin, ... }@inputs:
    let
      inherit (self) outputs;

      # Import home-manager and nixos configuration
      home-manager-modules.default = import ./modules/home-manager;
      nixos-modules.default = import ./modules/nixos;

      # Nixpkgs overlays allow us to add custom packages to the nixpkgs set
      overlays = system: [
        # Get niri-stable and niri-unstable in pkgs
        niri.overlays.niri
        # Get extra neovim plugins in pkgs
        nixneovim.overlays.default
        (final: prev: {
          direnv-vim = final.callPackage ./pkgs/direnv-vim.nix { };
          xwayland-satellite =
            xwayland-satellite.packages.${system}.xwayland-satellite;
          ballad = ballad.packages.${system}.default;
        })
      ];

      # The default modules for all systems.
      # System specific modules are held in ./hosts/<hostname>
      default-modules = [
        nixos-modules.default
        # We do home-manager configuration in the nixos configuration instead of through the cli
        home-manager.nixosModules.home-manager

        # Enable Lix
        lix.nixosModules.default

        # Add our home-manager configuration
        {
          home-manager.sharedModules = [
            # Allow for easy home-manager and nixos configuration of niri
            niri.homeModules.config
            # Declarative neovim config
            nixneovim.nixosModules.default
            home-manager-modules.default
            # Catppuccin themes
            catppuccin.homeManagerModules.catppuccin
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
        noctiluca = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/noctiluca/configuration.nix ] ++ default-modules
            ++ [{ nixpkgs.overlays = overlays "x86_64-linux"; }];
          system = "x86_64-linux";
        };
      };
    };
}
