{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.niri.nixosModules.niri ];

  options.my.niri.enable = lib.mkEnableOption "the niri compositor";

  config = {
    # Use nixpkgs' niri: it comes from cache.nixos.org and is built against the
    # system's mesa, so the third-party niri-flake cache isn't needed.
    niri-flake.cache.enable = false;
    programs.niri.package = pkgs.niri;

    programs.niri.enable = config.my.niri.enable;

    # Noctalia provides the polkit agent, and only one can be registered at a time.
    systemd.user.services.niri-flake-polkit.enable = false;

    # niri binds the power key to the session panel. Without this, logind powers off.
    services.logind.settings.Login.HandlePowerKey = "ignore";
  };
}
