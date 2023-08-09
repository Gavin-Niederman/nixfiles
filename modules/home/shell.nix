{ config, ... }:

{
    config = {
        programs.starship.enable = true;
        programs.nushell = {
            enable = true;
            configFile.text = ''
                $env.config = {
                    show_banner: false,
                }
            '';
        };
        programs.fish.enable = true;
    };
}