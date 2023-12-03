{ pkgs, ... }:

{
  config = {
    nix = {
      package = pkgs.nixUnstable;

      settings.experimental-features =
        [ "nix-command" "flakes" ];

      settings = {
        substituters =
          [ "https://nix-community.cachix.org" "https://hyprland.cachix.org" "https://cargo-pros.cachix.org"  ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "cargo-pros.cachix.org-1:O1mgMamsjaUUT8lQqEcr2b7c/6T2IBXtNcV39F50mSk="
        ];
      };
    };

    nixpkgs.config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };
}
