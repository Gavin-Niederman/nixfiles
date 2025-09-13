{ ... }:

{
  imports = [
    # Linux user configuration
    ./user.nix
    # Nix toolchain configuration
    ./nix.nix
    # Bootloader configuration
    ./boot.nix
    # DE config
    ./env.nix
    # Font installation
    ./fonts.nix
    # Keyboard input configuration (fxitx, power button, etc...)
    ./input.nix
    # Declarative Niri output config
    ./monitors.nix
    ./ssh.nix
    ./cutter.nix
    # Remote devices configuration (e.g. printers kde connect)
    ./devices.nix
    ./locate.nix
  ];

  # The version of nixpkgs that we are using to configure the system.
  config = { system.stateVersion = "24.05"; };
}
