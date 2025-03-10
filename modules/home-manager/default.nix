{ ... }:

{
  # You can import other home-manager modules here
  imports = [
    # Nix toolchain configuration
    ./nix.nix
    # General application configuration
    ./applications.nix
    # Niri configuration
    ./niri.nix
    # Fonts and fontconfig
    ./fonts.nix
    # System theming
    ./theme.nix
    # vscode and neovim
    ./editor.nix
    # Nushell starship carapace and fish
    ./shell.nix
    # DE (Ballad) configuration
    ./ballad.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
