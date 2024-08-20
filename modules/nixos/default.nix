{ ... }:

{
  imports = [
    # Linux user configuration
    ./user.nix
    # Nix toolchain configuration
    ./nix.nix
    # Bootloader configuration
    ./boot.nix
  ];

  # The version of nixpkgs that we are using to configure the system.
  config = { system.stateVersion = "24.11"; };
}
