{ pkgs, ... }:

{
  config = {
    nixpkgs.config.allowUnfree = true;
    nix = {
      package = pkgs.nixFlakes;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
      settings = {
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        ];
      };
    };
  };
}
