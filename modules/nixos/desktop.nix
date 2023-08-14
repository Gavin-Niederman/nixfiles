{ config, pkgs, ... }:

{
  config = {
    programs.regreet.enable = true;

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

      ags
      # watershot

      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
        ];
      })
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
