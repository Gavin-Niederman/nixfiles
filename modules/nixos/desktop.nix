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
            trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
        };

        services.pipewire = {
            enable = true;
            alsa.enable = true;
            pulse.enable = true;
        };

        environment.systemPackages = with pkgs; [
            webcord-vencord
            gnome.nautilus

            swaylock-effects
            swayidle

            swww

            pamixer
            wine-wayland

            ags
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