{ pkgs, ... }:

{
  home.packages = [ pkgs.rustup pkgs.clang pkgs.thunderbird pkgs.rnote ];

  programs.firefox = {
    enable = true;
    # Keep the pre-26.05 profile location; moving it would orphan the existing profile.
    configPath = ".mozilla/firefox";
  };
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font Mono";
    # Acrylic look: translucent background, niri blurs behind it (see niri.nix)
    settings = {
      background_opacity = "0.8";
      dynamic_background_opacity = true;
    };
  };
  programs.fuzzel = {
    enable = true;
  };

  programs.git = {
    enable = true;

    settings.user = {
      email = "gavinniederman@gmail.com";
      name = "Gavin-Niederman";
    };
  };
  programs.gh.enable = true;

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
    ];
  };

  # Input method with fcitx5 safegaurds
  gtk.gtk4.extraConfig.gtk-im-module = "fcitx";
  dconf.settings."org/gnome/settings-daemon/plugins/xsettings" = {
    overrides = "{'Gtk/IMModule':<'fcitx'>}";
  };

  # Desktop file for running vesktop without the gpu
  xdg = {
    enable = true;
    desktopEntries.vesktopNoGpu = {
      exec = "vesktop --disable-gpu";
      categories = [ "Network" "InstantMessaging" "Chat" ];
      genericName = "Internet Messenger";
      icon = "vesktop";
      name = "Vesktop (No GPU)";
      type = "Application";
      settings = {
        Keywords = "discord;vencord;electron;chat;gpu";
        StartupWMClass = "Vesktop";
        Version = "1.4";
      };
    };
  };
}
