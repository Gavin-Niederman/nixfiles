{ pkgs, ... }:
{
  programs.ghostty.enable = true;

  # For pasting in terms
  home.packages = [ pkgs.wl-clipboard ];
}
