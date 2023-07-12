{
  description = "My Nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }:
    let 
      nixosModules.default = import ./modules/nixos;
      homeModules.default = import ./modules/home;
    in rec {
      nixosConfigurations = {
          patria = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ 
              ./hosts/patria/configuration.nix 
              nixosModules.default
              home-manager.nixosModules.home-manager
              {
                home-manager.sharedModules = [
                  hyprland.homeManagerModules.default
                ];
              }
            ];
          };
        };

      homeConfigurations = {
        "gavin@patria" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            homeModules.default
            hyprland.homeManagerModules.default
            
            {wayland.windowManager.hyprland.enable = true;}
          ];
        };
      };
  };
}
