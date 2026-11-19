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
  # Puts nushell in /etc/shells. pkexec (used by e.g. OBS to modprobe
  # v4l2loopback) refuses to run when $SHELL is not listed there.
  environment.shells = [ pkgs.nushell ];
  security.sudo.wheelNeedsPassword = false;

  home-manager = {
    useGlobalPkgs = true;

    users = lib.attrsets.genAttrs [ "gavin" ] (_: { });
  };
}
