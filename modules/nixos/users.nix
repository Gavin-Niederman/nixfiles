{ inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  users.users.gavin = {
    isNormalUser = true;
    description = "Gavin";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.gavin = ../home;
  };
}
