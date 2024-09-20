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
      output = { ... }: {
        options = {
          output = mkOption { type = types.str; };
          position = mkOption { type = types.submodule vec2; default = null; };
          mode = mkOption { type = types.submodule mode; default = null; };
        };
      };
    in {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
      outputs = mkOption {
        type = types.listOf (types.submodule output);
        default = [];
      };
    };
  };

  config = with lib;
    let 
      cfg = config.hardware.monitors;
      mkNiriOutput = m: ''
        output "${m.output}" {
          ${strings.optionalString (m.mode != null) ''mode "${toString m.mode.size.x}x${toString m.mode.size.y}@${m.mode.refreshRate}"''}
          ${strings.optionalString (m.position != null) ''position x=${toString m.position.x} y=${toString m.position.y}''}
        }
      '';
    in mkIf cfg.enable {
      home-manager.sharedModules = [
        {
          programs.niri.extraConfig = strings.concatStringsSep "\n" (map mkNiriOutput cfg.outputs);
        }
      ];
    };
}
