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
    nautilus # file manager
  ];
  # Useful utilities that happen to be made by gnome
  services.gnome.core-apps.enable = true;
  # Trash can and other fs stuff
  services.gvfs.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
    # keyd sends KEY_COMPOSE for capslock; this makes xkb emit Multi_key
    # rather than the Menu keysym. Mirrors the niri xkb options.
    options = "compose:menu";
  };

  environment.systemPackages =
    [ pkgs.xdg-utils pkgs.niri-unstable pkgs.nemo pkgs.nemo-fileroller pkgs.file-roller ];
  # XDG makes everything better
  xdg = {
    autostart.enable = true;
    menus.enable = true;
    mime.enable = true;
    # VS Code's desktop file also claims inode/directory; pin nemo.
    mime.defaultApplications."inode/directory" = "nemo.desktop";
    icons.enable = true;
  };

  # Enable three portals for optimal compatibility.
  xdg.portal = {
    enable = true;
    extraPortals = [
      (pkgs.xdg-desktop-portal-gtk.override {
        # Do not build portals that are in the gnome portal.
        # buildPortalsInGnome = false;
      })
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
    ];

    configPackages = [ pkgs.niri-stable ];
    # The niri package ships its own `niri-portals.conf` (default=gnome;gtk).
    # xdg-desktop-portal prefers a `<desktop>-portals.conf` from any search
    # dir over a generic `portals.conf`, so `config.common` alone is ignored
    # under niri and the gnome portal ends up delegating FileChooser to the
    # (uninstalled) Nautilus. Writing `config.niri` puts our preferences in
    # /etc/xdg, which is searched before the package's share dir.
    # Keys must use the backend (`impl`) interface names; the frontend
    # names (`org.freedesktop.portal.*`) are silently ignored.
    config = let
      preferences = {
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];

        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];

        default = "wlr";
      };
    in {
      common = preferences;
      niri = preferences;
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
        "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
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

  # For Figma fonts
  systemd.user.services.figma-agent = {
    description = "Figma Agent (figma font helper)";
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart =
        "${pkgs.figma-agent}/bin/figma-agent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
