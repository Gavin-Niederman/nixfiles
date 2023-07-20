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
                workspace = mkOption {
                    type = types.nullOr types.int;
                    default = null;
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
        mkHyprlandWorkspace = m:
            if (m.workspace != null) then "workspace=${m.output},${toString m.workspace}" else "";
        mkHyprlandMonitor = m:
            "monitor=${m.output},${toString m.dimensions.x}x${toString m.dimensions.y}@${toString m.refreshRate},${toString m.offset.x}x${toString m.offset.y},${toString m.scale}";
        monitors = (map mkHyprlandMonitor config.monitors) ++ (map mkHyprlandWorkspace config.monitors);
    in {
        home-manager.sharedModules = [
            {
                wayland.windowManager.hyprland.extraConfig = "${concatStringsSep "\n" monitors}";
            }
        ];
    };
}