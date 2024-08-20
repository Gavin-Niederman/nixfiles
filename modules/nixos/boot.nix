{ pkgs, ... }:

{
  config = {
    boot.loader = {
      grub = {
        enable = true;
        configurationLimit = 5;
        device = "/dev/disk/by-uuid/B461-39A9";
      };
      timeout = 5;
    };
    boot.plymouth = {
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      enable = true;
      theme = "cuts_alt";
    };
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command =
            "${pkgs.cage}/bin/cage -s ${pkgs.greetd.gtkgreet}/bin/gtkgreet";
        };
      };
    };
    services.logind.extraConfig = ''
      HandlePowerKey=ignore
    '';
    environment.etc."greetd/environments".text = ''
      Hyprland
      nu
    '';
  };
}
