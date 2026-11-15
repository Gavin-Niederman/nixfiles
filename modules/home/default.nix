{
  imports = [
    ./browser.nix
    ./btop.nix
    ./compose.nix
    ./cursors.nix
    ./discord.nix
    ./feishin.nix
    ./figma.nix
    ./fonts.nix
    ./gimp.nix
    ./git.nix
    ./launcher.nix
    ./kdeconnect.nix
    ./niri.nix
    ./noctalia.nix
    ./obs.nix
    ./signal.nix
    ./terminal.nix
  ];

  home = {
    username = "gavin";
    homeDirectory = "/home/gavin";
    stateVersion = "26.11";
  };

  programs.home-manager.enable = true;
}
