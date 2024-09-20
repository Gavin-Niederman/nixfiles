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

  home-manager.sharedModules = [{
    programs.niri.extraConfig = ''
      // Input method
      spawn-at-startup "${config.i18n.inputMethod.package}/bin/fcitx5" "-d" "-r"
    '';
  }];
}
