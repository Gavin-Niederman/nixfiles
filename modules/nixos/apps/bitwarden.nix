{ pkgs, ... }:
{
  # Installed system-wide because polkit only reads action policies from the
  # system profile, and biometric unlock needs Bitwarden's policy.
  environment.systemPackages = [ pkgs.bitwarden-desktop ];
}
