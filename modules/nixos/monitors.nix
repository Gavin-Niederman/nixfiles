{ lib, config, ... }:

{
  options = with lib; {
    hardware.monitors = let
      vec2 = { ... }: {
        options = {
          x = mkOption { type = types.int; };
          y = mkOption { type = types.int; };
        };
      };
      mode = { ... }: {
        options = {
          refreshRate = mkOption { type = types.str; };
          size = mkOption { type = types.submodule vec2; };
        };
      };
      monitor = { ... }: {
        options = {
          output = mkOption { type = types.str; };
          position = mkOption { type = types.submodule vec2; default = null; };
          mode = mkOption { type = types.submodule mode; default = null; };
        };
      };
    in mkOption {
      type = types.listOf (types.submodule monitor);
      default = null;
    };
  };

  config = with lib;
    let 
      mkNiriOutput = m: ''
        output "${m.output}" {
          ${strings.optionalString (m.mode != null) ''mode "${toString m.mode.size.x}x${toString m.mode.size.y}@${m.mode.refreshRate}"''}
          ${strings.optionalString (m.position != null) ''position x=${toString m.position.x} y=${toString m.position.y}''}
        }
      '';
    in {
      home-manager.sharedModules = [
        {
          programs.niri.extraConfig = strings.concatStringsSep "\n" (map mkNiriOutput config.hardware.monitors);
        }
      ];
    };
}
