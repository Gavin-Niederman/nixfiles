{ pkgs, ... }:

{
  environment.systemPackages =
    [ (pkgs.cutter.withPlugins (plugins: [ plugins.rz-ghidra ])) ];
}
