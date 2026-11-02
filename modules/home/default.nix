{
  imports = [
    ./browser.nix
    ./btop.nix
    ./cursors.nix
    ./feishin.nix
    ./git.nix
    ./launcher.nix
    ./niri.nix
    ./noctalia.nix
    ./terminal.nix
  ];

  home = {
    username = "gavin";
    homeDirectory = "/home/gavin";
    stateVersion = "26.11";
  };

  programs.home-manager.enable = true;
}
