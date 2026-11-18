{
  imports = [
    ./apps # graphical applications
    ./cli # command-line tools
    ./desktop # compositor, shell, terminal and look and feel
  ];

  home = {
    username = "gavin";
    homeDirectory = "/home/gavin";
    stateVersion = "26.11";
  };

  programs.home-manager.enable = true;
}
