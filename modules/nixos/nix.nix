# Nix toolchain configuration
{ ... }:

{
  nix =
    {
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";

        substituters = [ "https://niri.cachix.org" ];
        trusted-public-keys =
          [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
      };
    };
  nixpkgs.config.allowUnfree = true;
}
