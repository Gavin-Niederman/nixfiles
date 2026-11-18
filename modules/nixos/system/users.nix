{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  users.users.gavin = {
    isNormalUser = true;
    description = "Gavin";
    extraGroups = [
      "docker"
      "networkmanager" # manage network connections
      "wheel" # sudo
      "dialout" # serial devices (/dev/ttyUSB*, /dev/ttyACM*) — Arduino, microcontrollers
      "uucp" # legacy serial group some tools still expect
      "video" # webcams, backlight control
      "render" # GPU render nodes (compute / hardware accel)
      "kvm" # hardware virtualization for VMs and emulators
    ]
    ++ lib.optional config.programs.gamemode.enable "gamemode";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.gavin = ../../home;
  };
}
