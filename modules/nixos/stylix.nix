{ pkgs, ... }:

{
    stylix = {
        enable = true;
        image = ../home-manager/wallpaper/dragons_nord.png;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
        polarity = "dark";
        targets.grub.enable = false;
    };
}