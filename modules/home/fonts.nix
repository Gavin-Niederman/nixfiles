{ config, ... }:
{
  fonts.fontconfig.enable = true;

  # Extra font directory for fonts dropped in by hand, outside of Nix.
  # Run `fc-cache -f` after adding fonts if they do not show up right away.
  xdg.configFile."fontconfig/conf.d/20-documents-fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>
      <dir>${config.home.homeDirectory}/Documents/fonts</dir>
    </fontconfig>
  '';
}
