{ ... }:

{
  config = {
    programs.starship.enable = true;
    home.file.".config/starship.toml".source = ./starship/starship.toml;

    programs.carapace.enable = true;
    programs.nushell = {
      enable = true;
      configFile.source = ./nu/config.nu;
      envFile.source = ./nu/env.nu;
    };

    programs.fish.enable = true;

    programs.wezterm = {
      enable = true;
      extraConfig = ''
        local wezterm = require 'wezterm'
        local config = {}

        config.color_scheme = 'Bright'
	      config.enable_wayland = false

        return config
      '';
      colorSchemes = { Bright = { foreground = "#FFFFFF"; }; };
    };
  };
}
