{ config, lib, ... }:

{
    options = 
    with lib;
    let
        vec2Module = { ... }: {
            options = {
                x = mkOption {
                    type = types.int;
                    default = 0;
                };
                y = mkOption {
                    type = types.int;
                    default = 0;
                };
            };
        };
        monitorModule = { ... }: {
            options = {
                output = mkOption {
                    type = types.str;
                };
                dimensions = mkOption {
                    type = types.submodule vec2Module;
                };
                refreshRate = mkOption {
                    type = types.int;
                };
                offset = mkOption {
                    type = types.submodule vec2Module;
                };
                scale = mkOption {
                    type = types.int;
                };
            };
        };
    in {
        monitors = mkOption {
            type = with types; listOf (submodule monitorModule);
            default = null;
        };
    };

    config = with lib; let
        mkHyprlandMonitor = m:
            [ "monitor=" (toString m.output) "," (toString m.dimensions.x) "x" (toString m.dimensions.y) "@" (toString m.refreshRate) "," (toString m.offset.x) "x" (toString m.offset.y) "," (toString m.scale) "\n"];

        monitors = concatMap mkHyprlandMonitor config.monitors;
    in {
        home-manager.sharedModules = [
            {
                wayland.windowManager.hyprland.extraConfig = "${concatStringsSep "" monitors}";
            }
        ];
    };
}