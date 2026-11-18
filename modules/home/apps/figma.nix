{ lib, pkgs, ... }:
{
  home.packages = [ pkgs.figma-agent ];

  # Serves local fonts to the Figma web app on 127.0.0.1:44950. It reads them
  # through fontconfig, so it picks up the directories set in fonts.nix.
  systemd.user.services.figma-agent = {
    Unit.Description = "Figma Agent for Linux";
    Service = {
      ExecStart = lib.getExe pkgs.figma-agent;
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
