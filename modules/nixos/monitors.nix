{ config, lib, ... }:

{
  options = with lib;
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
          output = mkOption { type = types.str; };
          dimensions = mkOption { type = types.submodule vec2Module; };
          refreshRate = mkOption { type = types.int; };
          offset = mkOption { type = types.submodule vec2Module; };
          scale = mkOption { type = types.int; };
          id = mkOption { type = types.int; };
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

  config = with lib;
    let
      mkEwwWindow = m: ''
        (defwindow ${m.output}
            :monitor ${toString m.id}
            :geometry (geometry
                :width "100%"
                :height "3%"
                :anchor "top center"
            )
            :exclusive true
            :focusable false
            :class "bar"
            (bar)
        )
      '';
      ewwWindows = map mkEwwWindow config.monitors;

      mkAgsWindow = m: ''
        ags.Window({
            name: '${m.output}',
            className: 'bar',
            monitor: ${toString m.id},
            anchor: ["top"],
            exclusive: true,
            child: {
                bar
            }
        }),
      '';
      agsWindows = map mkAgsWindow config.monitors;

      mkHyprlandWorkspace = m:
        if (m.workspace != null) then
          "workspace=${m.output},${toString m.workspace}"
        else
          "";
      mkHyprlandMonitor = m:
        "monitor=${m.output},${toString m.dimensions.x}x${
          toString m.dimensions.y
        }@${toString m.refreshRate},${toString m.offset.x}x${
          toString m.offset.y
        },${toString m.scale}";
      monitors = filter (s: s != "") ((map mkHyprlandMonitor config.monitors)
        ++ (map mkHyprlandWorkspace config.monitors));
    in {
      home-manager.sharedModules = [{
        wayland.windowManager.hyprland.extraConfig =
          "${concatStringsSep "\n" monitors}";
        home.file.".config/eww/eww.yuck".text =
          "${concatStringsSep "\n" ewwWindows}";
        home.file.".config/ags/config.js".text = ''
          const monitors = [
              ${concatStringsSep "\n" agsWindows}
          ];
        '';
      }];
    };
}
