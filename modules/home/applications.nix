{ pkgs, ... }:

{
  config = {
    services.easyeffects.enable = true;
    services.mako.enable = true;
    
    programs.firefox.enable = true;
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
    };

    home.packages = with pkgs; [ ags swww ];
  };
}