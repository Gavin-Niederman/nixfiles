# Linux user configuration
{ ... }:

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
}
