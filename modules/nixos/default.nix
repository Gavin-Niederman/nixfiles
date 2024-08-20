{ ... }:

{
  imports = [
    ./nix.nix
    ./user.nix
    ./monitors.nix
    ./boot.nix
    ./security.nix
    ./fonts.nix
    ./audio.nix
    ./utilities.nix
    ./applications.nix
  ];
  config = { system.stateVersion = "23.11"; };
}
