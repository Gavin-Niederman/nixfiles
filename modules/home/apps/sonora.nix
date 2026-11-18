{ inputs, ... }:
{
  imports = [ inputs.sonora.homeModules.default ];

  programs.sonora.enable = true;
}
