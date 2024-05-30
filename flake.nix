{
  description = "My Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    split-monitor-workspaces = {
      url = "github:bivsk/split-monitor-workspaces?ref=bivsk";
      inputs.hyprland.follows = "hyprland";
    };

    frc-nix = {
      url = "github:frc3636/frc-nix?ref=svg-icons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixneovim.url = "github:nixneovim/nixneovim";
    ags.url = "github:Aylur/ags";
  };

  outputs = { nixpkgs, home-manager, hyprland, hyprlock, hypridle
    , split-monitor-workspaces, frc-nix, nixneovim, ags, ... }:
    let
      nixosModules.default = import ./modules/nixos;
      homeModules.default = import ./modules/home;

      overlays = system: [
        nixneovim.overlays.default
        frc-nix.overlays.default
        (final: prev: {
          ags = ags.packages.${system}.default;
          hyprlandPlugins =
            [ split-monitor-workspaces.packages.${system}.default ];
          direnv-vim = final.callPackage ./pkgs/direnv-vim.nix { };
          fvim = final.callPackage ./pkgs/fvim.nix { };
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
            hyprlock.homeManagerModules.default
            hypridle.homeManagerModules.default
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
