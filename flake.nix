{
  description = "My personal NixOS configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;

      # Import home-manager and nixos configuration
      home-manager-modules.default = import ./modules/home-manager;
      nixos-modules.default = import ./modules/nixos;

      # Nixpkgs overlays allow us to add custom packages to the nixpkgs set
      overlays = system:
        [
          (final: prev:
            {
              # Add packages here
            })
        ];

      # The default modules for all systems.
      # System specific modules are held in ./hosts/<hostname>
      default-modules = [
        nixos-modules.default
        # We do home-manager configuration in the nixos configuration instead of through the cli
        home-manager.nixosModules.home-manager
        # Add our home-manager configuration
        { home-manager.sharedModules = [ home-manager-modules.default ]; }
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
