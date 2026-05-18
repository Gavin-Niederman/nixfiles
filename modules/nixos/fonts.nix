{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    anonymousPro
    lato
    nerd-fonts.fira-code
  ];
}
