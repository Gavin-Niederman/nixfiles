{ config, pkgs, lib, ... }:
{
    config = {
        programs.vscode = {
            enable = true;

            extensions = with pkgs.vscode-extensions; [
                # Looks
                jdinhlife.gruvbox
                pkief.material-icon-theme

                # Languages
                rust-lang.rust-analyzer
                tamasfe.even-better-toml
                serayuzgur.crates

                bbenoist.nix
                brettm12345.nixfmt-vscode

                thenuprojectcontributors.vscode-nushell-lang

                yzhang.markdown-all-in-one
                marp-team.marp-vscode

                haskell.haskell

                # Copilot
                github.copilot
                github.copilot-chat

                # Misc
                mkhl.direnv
                ms-vscode.live-server
            ];
        };
    };
}