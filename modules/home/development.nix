{ pkgs, ... }:

{
  config = {
    programs.git = {
      enable = true;

      userEmail = "gavinniederman@gmail.com";
      userName = "Gavin-Niederman";
    };
    programs.gh.enable = true;

    programs.direnv.enable = true;

    home.packages = with pkgs; [
      rustup
      nixfmt
    ];
  };
}
