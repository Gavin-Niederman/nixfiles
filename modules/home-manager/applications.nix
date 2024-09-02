{ pkgs, ... }:
let
  kittyNord = pkgs.stdenv.mkDerivation {
    pname = "nord-kitty";
    version = "1.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "connorholyday";
      repo = "nord-kitty";
      rev = "3a819c1f207cd2f98a6b7c7f9ebf1c60da91c9e9";
      hash = "sha256-Zbmrp2sQO0upkQ6Gtt5O4SLzPhovUDQNjvM0x8v2a0g=";
    };
    installPhase = ''
      mkdir -p $out/share/kitty/themes
      cp nord.conf $out/share/kitty/themes
    '';
  };
in {
  programs.firefox = { enable = true; };
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font Mono";
    extraConfig = ''
      include ${kittyNord}/share/kitty/themes/nord.conf
    '';
  };
  programs.fuzzel.enable = true;
}
