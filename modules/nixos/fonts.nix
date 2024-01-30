{ pkgs, ... }:

{
  config = {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      ibm-plex
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };
}
