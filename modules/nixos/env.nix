# Desktop environment/window manager configuration
{ pkgs, ... }:

{
  environment.gnome.excludePackages = with pkgs; [
    cheese # webcam tool
    gedit # text editor
    epiphany # web browser
    geary # email reader
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    gnome-console # terminal emulator
    gnome-text-editor # text editor (again)
  ];
  # Useful utilities that happen to be made by gnome
  services.gnome.core-utilities.enable = true;
  # Trash can and other fs stuff
  services.gvfs.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Slop that nix-generate-config generates
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

  environment.systemPackages = [ pkgs.xdg-utils pkgs.niri-unstable ];
  # XDG makes everything better
  xdg = {
    autostart.enable = true;
    menus.enable = true;
    mime.enable = true;
    icons.enable = true;
  };

  # Enable three portals for optimal compatibility.
  xdg.portal = {
    enable = true;
    extraPortals = [
      (pkgs.xdg-desktop-portal-gtk.override {
        # Do not build portals that are in the gnome portal.
        buildPortalsInGnome = false;
      })
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
    ];

    configPackages = [ pkgs.niri-stable ];
    config.common = {
      "org.freedesktop.portal.Secret" = [ "gnome-keyring" ];

      "org.freedesktop.portal.FileChooser" = [ "gtk" ];

      default = "wlr";
    };
  };

  # Enable polkit and gnome-keyring for authentication.
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  systemd.user.services.kde-polkit = {
    description = "KDE PolicyKit Authentication Agent";
    wantedBy = [ "niri.service" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart =
        "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  security.pam.services.swaylock = { };
  programs.dconf.enable = true;
  fonts.enableDefaultPackages = true;

  # For battery status
  services.upower.enable = true;
  # For power profile configuration
  services.power-profiles-daemon.enable = true;
}
