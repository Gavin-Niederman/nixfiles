{ pkgs, lib, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 42;
  };

  # Fixes cursor size on gtk apps and firefox
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      cursor-size = lib.hm.gvariant.mkInt32 42;
    };
  };

  home.packages = with pkgs; [
    adwaita-icon-theme
    morewaita-icon-theme
  ];

  gtk = {
    enable = true;

    cursorTheme = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
    };

    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };

    theme = {
      name = "Nordic-darker";
      package = pkgs.nordic;
    };
  };
}
