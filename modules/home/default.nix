{ ... }:

{
  imports = [
    ./hyprland.nix
    ./editor.nix
    ./shell.nix
    ./theme.nix
    ./applications.nix
    ./development.nix
  ];
  config = { home.stateVersion = "23.11"; };
}
