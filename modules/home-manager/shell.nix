{ pkgs, ... }:

{
  programs.starship.enable = true;
  home.file.".config/starship.toml".source = ./starship/starship.toml;

  programs.direnv = {
    enable = true;
    # Faster devshell evaluation
    nix-direnv.enable = true;
  };

  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;
  programs.nushell = {
    enable = true;
    configFile.text = ''
      $env.config = {
        show_banner: false,
        completions: {
          case_sensitive: false,
          quick: true,
          partial: true,
          algorithm: 'fuzzy',
          external: {
              enable: true,
          }
        }
      }
    '';
    envFile.text = ''
      $env.STARSHIP_CONFIG = $"($env.HOME)/.config/starship.toml"
    '';
  };
  programs.fish.enable = true;

  home.packages = [ (pkgs.writeShellScriptBin "bg" ''
    nohup $@ >/dev/null 2>/dev/null & disown
  '') ];
}
