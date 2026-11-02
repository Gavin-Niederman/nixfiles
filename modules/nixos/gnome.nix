{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.my.gnome.enable = lib.mkEnableOption "GNOME apps and services, without the GNOME desktop";

  config = lib.mkIf config.my.gnome.enable {
    services.gnome.core-apps.enable = true;
    environment.gnome.excludePackages = with pkgs; [
      cheese
      gedit
      epiphany
      geary
      tali
      iagno
      hitori
      atomix
      gnome-console
      gnome-music # needs the localsearch file indexer
      gnome-text-editor
      nautilus
    ];

    # File manager, replacing nautilus.
    environment.systemPackages = with pkgs; [
      nemo
      adwaita-icon-theme
    ];

    # Open folders and "show in folder" requests in nemo.
    xdg.mime.defaultApplications."inode/directory" = "nemo.desktop";
    services.dbus.packages = [ pkgs.nemo ];

    # Trash and other filesystem integration.
    services.gvfs.enable = true;
    services.gnome.gnome-keyring.enable = true;
    programs.dconf.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    hardware.bluetooth.enable = true;

    # Backends the apps above rely on, normally enabled by the GNOME desktop.
    services.gnome = {
      evolution-data-server.enable = true; # Calendar, Contacts
      glib-networking.enable = true; # TLS
    };
    fonts.packages = [ pkgs.adwaita-fonts ];

    # The GNOME portal's file chooser needs nautilus, so use the GTK one.
    xdg.portal = {
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      # This replaces niri-portals.conf from the niri package. GTK stays as the
      # fallback for interfaces the GNOME portal lacks, like Inhibit and Email.
      config.niri = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };
  };
}
