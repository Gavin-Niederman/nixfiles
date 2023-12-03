{ pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [ nushell ];
    programs.starship.enable = true;
  };
}
