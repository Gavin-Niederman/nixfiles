{ pkgs, ... }:

{
  home.packages = [ pkgs.rustup pkgs.clang pkgs.thunderbird ];

  programs.firefox = { enable = true; };
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font Mono";
    catppuccin.enable = true;
  };
  programs.fuzzel = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.git = {
    enable = true;

    userEmail = "gavinniederman@gmail.com";
    userName = "Gavin-Niederman";
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
}
