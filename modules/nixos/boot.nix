{ pkgs, ... }:

{
    config = {
        boot.plymouth = {
            themePackages = [ pkgs.adi1090x-plymouth-themes ];
            enable = true;
            theme = "cuts_alt";
        };
    };
}