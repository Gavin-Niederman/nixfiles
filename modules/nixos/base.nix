{ pkgs, ... }:
{
  # Must be >= 6.17 for the Framework 13 Pro (Intel Core Ultra Series 3).
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader = {
    timeout = 1;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  services.printing.enable = true;
  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
