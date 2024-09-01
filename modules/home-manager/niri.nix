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

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 42;
  };
}