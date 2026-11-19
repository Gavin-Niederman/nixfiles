# Bootloader configuration.
# I use GRUB as my bootloader with os-prober to detect other operating systems.
{ pkgs, config, ... }:

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
  boot = {
    # v4l2loopback for the OBS virtual camera. Loaded at boot so OBS does not
    # need to modprobe it (via pkexec) at runtime. video_nr=10 keeps it clear
    # of the real webcam, which takes /dev/video0 and /dev/video1.
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    kernelModules = [ "v4l2loopback" ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=10 card_label="OBS Cam" exclusive_caps=1
    '';
  };

  services.accounts-daemon.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet --user-menu -r -c "${pkgs.niri-unstable}/bin/niri-session"'';
      };
    };
  };
  environment.etc."greetd/environments".text = ''
    ${pkgs.niri-unstable}/bin/niri-session
    nu
  '';
  services.logind.settings.Login.HandlePowerKey = "ignore";

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "gavin" ];
}
