{ pkgs, ... }:

{
  config = {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };
    virtualisation.docker.enable = true;

    environment.systemPackages = [ pkgs.fvim ];

    programs.hyprland.enable = true;
  };
}
