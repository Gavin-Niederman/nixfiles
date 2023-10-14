{ config, ... }:

{
  config = {
    programs.starship.enable = true;
    programs.carapace.enable = true;
    programs.nushell = {
      enable = true;
      configFile.source = ./nu/config.nu;
    };
    programs.fish.enable = true;
    programs.wezterm.enable = true;
  };
}
