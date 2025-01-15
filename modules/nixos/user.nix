# Linux user configuration
{ pkgs, lib, ... }:

{
  users.users = {
    gavin = {
      initialPassword = "gavin";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [ "wheel" "networkmanager" "audio" "dialout" "keyd" ];
      shell = pkgs.nushell;
    };
  };
  security.sudo.wheelNeedsPassword = false;

  home-manager = {
    useGlobalPkgs = true;

    users = lib.attrsets.genAttrs [ "gavin" ] (_: { });
  };
}
