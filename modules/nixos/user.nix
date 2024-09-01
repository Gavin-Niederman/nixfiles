# Linux user configuration
{ lib, ... }:

{
  users.users = {
    gavin = {
      initialPassword = "gavin";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [ "wheel" "networkmanager" "audio" ];
    };
  };
  security.sudo.wheelNeedsPassword = false;

  home-manager = {
    useGlobalPkgs = true;

    users = lib.attrsets.genAttrs [ "gavin" ] (_: { });
  };
}
