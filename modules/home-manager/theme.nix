{ pkgs, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 42;
  };

  gtk = {
    enable = true;

    cursorTheme = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
    };

    iconTheme = {
      name = "kora";
      package = pkgs.kora-icon-theme;
    };

    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };
}
