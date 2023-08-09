{ config, pkgs, lib, ... }:

{
  config = {
    users.users.gavin = {
      isNormalUser = true;
      createHome = true;
      initialPassword = "gavin";
      description = "Gavin";
      extraGroups = [ "networkmanager" "wheel" "keyd" ];
      shell = pkgs.nushell;
    };

    security.sudo.wheelNeedsPassword = false;

    services.gnome.gnome-keyring.enable = true;
    security.polkit.enable = true;
    security.rtkit.enable = true;

    security.pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };

    environment.systemPackages = with pkgs; [ lxde.lxsession xdg-utils ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users = lib.attrsets.genAttrs [ "gavin" ] (_: { });
    };
  };
}
