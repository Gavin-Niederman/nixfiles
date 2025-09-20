{ ... }:

{
  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = [ "FiraCode" ];
  };

  home.file.".config/fontconfig/conf.d/100-user-fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <dir>~/Documents/fonts</dir>
    </fontconfig>
    '';
}
