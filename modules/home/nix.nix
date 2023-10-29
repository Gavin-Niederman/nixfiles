{ config, ... }:

{
    config = {
        nixpkgs.config = {
            allowUnfree = true;
        };
    };
}