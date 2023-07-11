{
  description = "My Nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@attrs:
    let 
      nixosModules.default = import ./modules/nixos;
      homeModules.default = import ./modules/home;
    in rec {
      nixosConfigurations = {
          patria = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = attrs;
            modules = [ ./hosts/patria/configuration.nix ] ++ [ nixosModules.default ];
          };
        };

      homeConfigurations = {
        "gavin@patria" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = attrs;
          modules = [ homeModules.default ];
        };
      };

      home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
        };
  };
}
