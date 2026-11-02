{ config, lib, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings.main.terminal = "${lib.getExe config.programs.ghostty.package} -e";
  };
}
