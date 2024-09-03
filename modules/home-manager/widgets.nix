{ pkgs, ... }:

{
  programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    configDir = ./ags;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [ gtksourceview webkitgtk accountsservice ];
  };
  home.packages = with pkgs;
    [ # Used to build ts ags config
      bun
    ];
}
