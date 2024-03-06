{ ... }:

{
  imports = [
    ./hyprland.nix
    ./editor.nix
    ./shell.nix
    ./theme.nix
    ./applications.nix
    ./development.nix
    ./backgrounds.nix
  ];
  config = { home.stateVersion = "23.11"; };
}
