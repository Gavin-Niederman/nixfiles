# Desktop environment/window manager configuration
{ pkgs, config, ... }:

{
  # programs.gnome-shell = {
  #   enable = true;
  #   extensions = [
  #     { package = pkgs.gnomeExtensions.paperwm; }
  #   ];
  # };

  home.file.".config/niri/config.kdl".source = ./niri/config.kdl; 
}