{
  programs.nh = {
    enable = true;
    flake = "/home/gavin/Dev/nixfiles";
    clean = {
      enable = true;
      extraArgs = "--keep 3";
    };
  };
}
