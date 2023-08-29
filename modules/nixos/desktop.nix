{ config, pkgs, ... }:

{
  config = {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command =
            "${pkgs.greetd.tuigreet}/bin/tuigreet --time -r --remember-session --cmd Hyprland --asterisks --window-padding 2 --container-padding 3 -w 100 -g Welcome back!";
          user = "greeter";
        };
        default_session = initial_session;
      };
    };

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
        main = {
          capslock = "overload(esc)";
          insert = "S-insert";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      webcord-vencord
      gnome.nautilus

      swaylock-effects
      swayidle

      swww
      lz4

      pamixer
      wine-wayland

      # Sassc is for ags theming
      sassc
      ags

      (pkgs.wrapOBS { plugins = with pkgs.obs-studio-plugins; [ wlrobs ]; })
    ];

    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
    ];
  };
}
