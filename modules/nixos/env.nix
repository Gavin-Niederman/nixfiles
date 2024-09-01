# Desktop environment/window manager configuration
{ pkgs, inputs, ... }:

{
  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # environment.gnome.excludePackages = with pkgs; [
  #   cheese # webcam tool
  #   gedit # text editor
  #   epiphany # web browser
  #   geary # email reader
  #   gnome.tali # poker game
  #   gnome.iagno # go game
  #   gnome.hitori # sudoku game
  #   gnome.atomix # puzzle game
  # ];

  # programs.niri.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.systemPackages = [pkgs.xdg-utils pkgs.niri-stable];
  xdg = {
    autostart.enable = true;
    menus.enable = true;
    mime.enable = true;
    icons.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
    configPackages = [pkgs.niri-stable];
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  # systemd.user.services.niri-flake-polkit = {
  #   description = "PolicyKit Authentication Agent provided by niri-flake";
  #   wantedBy = ["niri.service"];
  #   wants = ["graphical-session.target"];
  #   after = ["graphical-session.target"];
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
  #     Restart = "on-failure";
  #     RestartSec = 1;
  #     TimeoutStopSec = 10;
  #   };
  # };

  security.pam.services.swaylock = {};
  programs.dconf.enable = true;
  fonts.enableDefaultPackages = true;
}