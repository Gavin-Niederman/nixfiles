{
  imports = [
    ./browser.nix
    ./cursors.nix
    ./git.nix
    ./launcher.nix
    ./niri.nix
    ./terminal.nix
  ];

  home = {
    username = "gavin";
    homeDirectory = "/home/gavin";
    stateVersion = "26.11";
  };

  programs.home-manager.enable = true;
}
