{ pkgs, ... }:

{
  config = {
    services.easyeffects.enable = true;

    programs.firefox.enable = true;
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
    };

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
    
    home.packages = with pkgs; [ ags swww ];
  };
}
