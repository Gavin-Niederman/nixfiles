# Bootloader configuration.
# I use GRUB as my bootloader with os-prober to detect other operating systems.
{ pkgs, ... }:

# Package a silly GRUB theme
let
  bsolTheme = pkgs.stdenv.mkDerivation {
    pname = "bsol-theme";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "harishnkr";
      repo = "bsol";
      rev = "v1.0";
      hash = "sha256-sUvlue+AXW6VkVYy3WOUuSt548b6LoDpJmQPbgcZDQw=";
    };
    installPhase = ''
      cp -r bsol/ $out
    '';
  };

  niriWrapper = pkgs.writeShellScriptBin "niri" "${pkgs.niri-unstable} --session";
in {
  boot.loader = {
    efi = { canTouchEfiVariables = true; };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      # Allows GRUB to scan for other operating systems and add them to the bootloader
      useOSProber = true;
      # This saves space in our EFI partition
      configurationLimit = 10;
      # Use our grub theme
      theme = bsolTheme;
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu -r -c ${niriWrapper}/bin/niri";
      };
    };
  };
  environment.etc."greetd/environments".text = ''
    ${niriWrapper}/bin/niri --session
    nu
  '';
}
