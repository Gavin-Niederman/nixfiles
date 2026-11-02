{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.my.steam.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf config.my.steam.enable {
    programs.steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    programs.gamescope.enable = true;
    programs.gamemode.enable = true;
  };
}
