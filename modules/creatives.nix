{ config, pkgs, lib, ... }:
    with lib;
    let
        cfg = config.gavin.creatives;
    in
    {
        options.gavin.creatives = {
            image-editing = {
                enable = mkOption {
                    type = types.bool;
                    default = true;
                    description = "Enable image editing tools";
                };
            };
            video-creation = {
                enable = mkOption {
                    type = types.bool;
                    default = true;
                    description = "Enable video creation tools";
                };
            };
        };
        config = {
            environment.systemPackages = with pkgs;
                (if cfg.image-editing.enable then [ gimp inkscape ] else [ ])
                ++
                (if cfg.video-creation.enable then [ obs-studio davinci-resolve ] else [ ]);
        };
    }