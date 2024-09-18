{ pkgs, config, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = [ pkgs.fcitx5-mozc pkgs.fcitx5-gtk ];
      waylandFrontend = true;
    };
  };

  home-manager.sharedModules =
    [{ niri.autostart.fcitx5.package = config.i18n.inputMethod.package; }];
}
