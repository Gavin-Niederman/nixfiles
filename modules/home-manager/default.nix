{ ... }:

{
  # You can import other home-manager modules here
  imports = [
    # Nix toolchain configuration
    ./nix.nix
  ];

  # Home manager output path
  home = {
    username = "gavin";
    homeDirectory = "/home/gavin";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
