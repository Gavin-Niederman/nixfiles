{ config, pkgs, ... }:
{
  home.pointerCursor = {
    enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 36;
    gtk.enable = true;
    x11.enable = true;
  };

  # Writes the GTK settings and dconf keys that GTK apps read the cursor from.
  gtk.enable = true;

  programs.niri.settings.cursor = {
    theme = config.home.pointerCursor.name;
    size = config.home.pointerCursor.size;
  };
}
