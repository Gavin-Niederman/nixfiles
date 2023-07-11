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
  # let 
  #   nixosModules.default = import ./modules/nixos;

  #   defaultModules = [
  #     {
  #       nixpkgs = {
  #         config = {
  #           allowUnfree = true;
  #         };
  #       };
  #     }
  #     nixosModules.default
  #     hyprland.nixosModules.default
  #     home-manager.nixosModules.home-manager
  #     {
  #       home-manager.sharedModules = [
  #         hyprland.homeManagerModules.default
  #       ];
  #     }
  #   ];

  #   in 
    rec {
      nixosConfigurations = {
          patria = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = attrs;
            modules = [ ./hosts/patria/configuration.nix ]; # ++ defaultModules;
          };
        };

      homeConfigurations = {
        "gavin@patria" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = attrs;
          modules = [ ./home-manager/default.nix ]; # ++ defaultModules;
        };
      };
  };
}
