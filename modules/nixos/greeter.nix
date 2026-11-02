{
  config,
  lib,
  pkgs,
  ...
}:
let
  sessions = config.services.displayManager.sessionData.desktops;
in
{
  services.greetd = {
    enable = true;
    settings.default_session.command = lib.concatStringsSep " " [
      (lib.getExe pkgs.tuigreet)
      "--user-menu"
      "--remember"
      "--cmd ${lib.getExe' config.programs.niri.package "niri-session"}"
      "--sessions ${sessions}/share/wayland-sessions"
    ];
  };

  # Unlock the keyring at login.
  security.pam.services.greetd.enableGnomeKeyring = true;
}
