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

  home.packages = let
    allCatppuccin = map (flavor:
      pkgs.catppuccin-gtk.override {
        variant = flavor;
        accents = [ "sky" ];
      }) [ "macchiato" "frappe" "latte" "mocha" ];
  in with pkgs; [ adwaita-icon-theme morewaita-icon-theme ] ++ allCatppuccin;

  catppuccin = {
    flavor = "macchiato";
    accent = "sky";
  };

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

    # theme = {
    #   name = "catppuccin-macchiato-sky-standard";
    #   package = pkgs.catppuccin-gtk.override {
    #     variant = "macchiato";
    #     accents = [ "sky" ];
    #   };
    # };
  };
}
