{ pkgs, ... }:

{
  config = {
    security.sudo.wheelNeedsPassword = false;

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;
    security.polkit.enable = true;
    security.rtkit.enable = true;
    programs.dconf.enable = true;
    networking.firewall.enable = false;

    security.pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
    security.pam.services.hyprlock = {};

    environment.systemPackages = with pkgs; [ lxde.lxsession xdg-utils ];
  };
}
