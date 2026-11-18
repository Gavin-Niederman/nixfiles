{ config, pkgs, ... }:
{
  boot.plymouth = {
    enable = true;
    # Keeps the firmware's logo (from the ACPI BGRT table) on screen.
    theme = "bgrt";
    showDelay = 0;
    # bgrt draws this at the bottom of the screen. It defaults to the NixOS
    # logo, so use a transparent pixel to leave only the firmware's logo.
    logo = pkgs.runCommand "transparent.png" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
      magick -size 1x1 xc:none png32:$out
    '';
  };

  # Leave the splash on screen after plymouth exits, until the greeter draws
  # over it. greetd is already ordered after plymouth-quit-wait.service.
  systemd.services.plymouth-quit.serviceConfig.ExecStart = [
    ""
    "-${config.boot.plymouth.package}/bin/plymouth quit --retain-splash"
  ];

  # Hide boot messages so they don't appear over the splash.
  boot.consoleLogLevel = 3;
  boot.kernelParams = [
    "quiet"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "systemd.show_status=false"
    "udev.log_level=3"
  ];
}
