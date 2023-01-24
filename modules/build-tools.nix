{ config, pkgs, lib, ... }:
    with lib;
    let
        cfg = config.gavin.build-tools;
    in
    {
        options.gavin.build-tools = {
            rust = {
                enable = mkOption {
                    type = types.bool;
                    default = true;
                    description = "Enable rust build tools";
                };
            };
        };
        config = mkIf cfg.rust.enable {
            environment.systemPackages = with pkgs; [
                rustup
            ];
        };
    }