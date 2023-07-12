{ config, pkgs, lib, ... }:
{
    config = {
        programs.starship.enable = true;
        programs.nushell = {
            enable = true;
            configFile.text = ''
                let-env config = {
                    show_banner: false,
                }
            '';
        };
        programs.fish.enable = true;
    };
}