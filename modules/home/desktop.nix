{ pkgs, lib, ... }:

with lib.hm.gvariant; {
  config = {
    programs.firefox.enable = true;
    programs.fuzzel.enable = true;
    programs.alacritty.enable = true;

    services.easyeffects.enable = true;

    fonts.fontconfig.enable = true;

    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
    };

    home.file = {
      ".config/eww/scripts".source = ./eww/scripts;
      ".config/eww/widgets".source = ./eww/widgets;
      ".config/eww/eww.scss".source = ./eww/eww.scss;
      ".config/eww/eww.yuck".text = ''
        (include "widgets/widgets.yuck")

        (defwidget bar []
            (box
                :class "bg"
                (box
                    :class "center"
                    :halign "center"
                    :space-evenly false
                    (clock)
                )
            )
        )
      '';
    };

    home.file.".config/ags".source = ./ags;

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

    home.file.".config/electron-flags.conf".text = ''
      --enable-features=UseOzonePlatform
      --ozone-platform=wayland
    '';

    nixpkgs.config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };

    home.packages = [ pkgs.eww-wayland ];

    home.stateVersion = "23.11";
  };
}
