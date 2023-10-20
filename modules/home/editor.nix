{ config, pkgs, ... }: {
  config = {
    programs.vscode = {
      enable = true;

      mutableExtensionsDir = false;

      extensions = with pkgs.vscode-extensions;
        [
          # Looks
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
          justusadam.language-haskell

          astro-build.astro-vscode
          bradlc.vscode-tailwindcss
          dbaeumer.vscode-eslint

          ms-vscode.cpptools

          vadimcn.vscode-lldb

          # Copilot
          github.copilot

          # Misc
          mkhl.direnv
          ms-vsliveshare.vsliveshare
          ms-vscode.live-server
          wakatime.vscode-wakatime
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "gruvbox-themes";
            publisher = "tomphilbin";
            version = "1.0.0";
            sha256 = "sha256-DnwASBp1zvJluDc/yhSB87d0WM8PSbzqAvoICURw03c=";
          }
          {
            name = "better-comments";
            publisher = "aaron-bond";
            version = "3.0.2";
            sha256 = "sha256-hQmA8PWjf2Nd60v5EAuqqD8LIEu7slrNs8luc3ePgZc=";
          }
          {
            name = "pestfile";
            publisher = "xoronic";
            version = "0.4.1";
            sha256 = "sha256-hRLaNcQg42EEIiFqMbtmybx7piP9PK2CWJLtvUP95lU=";
          }
        ];

      userSettings = {
        # This fixes a crash on vscode startup
        "window.titleBarStyle" = "custom";
        "workbench.colorTheme" = "Gruvbox Dark (Soft)";
        "editor.inlineSuggest.enabled" = true;
        "editor.bracketPairColorization.enabled" = false;
        "workbench.iconTheme" = "material-icon-theme";
        "git.autofetch" = true;
        "github.copilot.enable" = {
          "*" = true;
          "plaintext" = false;
          "markdown" = false;
          "scminput" = false;
          "rust" = true;
        };
        "editor.fontLigatures" = true;
        "editor.fontFamily" = "FiraCode Nerd Font Mono";
        "terminal.fontFamily" = "FiraCode Nerd Font Mono";
        "git.confirmSync" = false;
        "rust-analyzer.inlayHints.chainingHints.enable" = false;
        "rust-analyzer.inlayHints.typeHints.enable" = false;
        "rust-analyzer.check.allTargets" = false;
        "workbench.settings.openDefaultKeybindings" = true;
        "window.zoomLevel" = 2;
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.cursorBlinking" = "smooth";
      };
    };
  };
}
