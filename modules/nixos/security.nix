{ pkgs, ... }:

{
  config = {
    security.sudo.wheelNeedsPassword = false;

    services.gnome.gnome-keyring.enable = true;
    security.polkit.enable = true;
    security.rtkit.enable = true;
    programs.dconf.enable = true;

    security.pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };

    environment.systemPackages = with pkgs; [ lxde.lxsession xdg-utils ];
  };
}
