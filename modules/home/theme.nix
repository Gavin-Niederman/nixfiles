{ pkgs, ... }:

{
	config = {
		home.file.".config/ags/".source = ./ags;
    home.packages = [ pkgs.sassc ];
		fonts.fontconfig.enable = true;

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
        name = "Fluent-teal";
        package = (pkgs.fluent-icon-theme.override {
          roundedIcons = true;
          colorVariants = [ "teal" ];
        });
      };

      theme = {
        name = "Fluent-teal-Dark";
        package = (pkgs.fluent-gtk-theme.override {
          themeVariants = [ "teal" ];
          tweaks = [ "noborder" ];
        });
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-size = 42;
      };
    };
	};
}
