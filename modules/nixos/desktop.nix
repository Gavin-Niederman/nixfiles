{ config, pkgs, ... }:

{
  config = {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command =
            "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu --time -r --remember-session --cmd Hyprland --asterisks --window-padding 2 --container-padding 3 -w 100 -g Welcome back!";
          user = "greeter";
        };
        default_session = initial_session;
      };
    };

    services.upower.enable = true;

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    programs.steam.enable = true;

    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    services.keyd = {
      enable = true;
      keyboards.default.settings = {
        main = { capslock = "overload(control, esc)"; };
      };
    };

    services.gnome.core-utilities.enable = true;
    environment.gnome.excludePackages = with pkgs.gnome; [
      epiphany
      gnome-contacts
      pkgs.gnome-connections
    ];

    programs.gnome-disks.enable = true;
    services.gnome.sushi.enable = true;
    services.sysprof.enable = true;
    xdg.mime.enable = true;
    xdg.icons.enable = true;

    environment.systemPackages = with pkgs; [
      wl-clipboard

      webcord-vencord

      swaylock-effects
      swayidle

      swww
      lz4

      pamixer
      pavucontrol

      wineWowPackages.waylandFull

      # Sassc is for ags theming
      sassc
      ags

      grimblast

      (pkgs.wrapOBS { plugins = with pkgs.obs-studio-plugins; [ wlrobs ]; })
    ];

    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };
}
