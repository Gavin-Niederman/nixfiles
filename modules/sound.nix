{ config, pkgs, lib, ... }:
    with lib;
    let
        cfg = config.gavin.audio;
    in
    {
        options.gavin.audio = {
            easyeffects = {
                enable = mkOption {
                    type = types.bool;
                    default = true;
                    description = "Enable easyfx";
                };
            };
        };
        config = {
            environment.systemPackages = with pkgs;
                (if cfg.easyeffects.enable then [ easyeffects ] else [ ]);

            programs.dconf.enable = cfg.easyeffects.enable;
        };
    }