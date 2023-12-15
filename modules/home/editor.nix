{ pkgs, ... }: {
  config = {
    programs.nixneovim = {
      enable = true;
      colorschemes.gruvbox-nvim.enable = true;
      mappings = {
        normal = {
          "<leader>ef" = "vim.cmd.NvimTreeFocus";
          "<leader>ee" = "vim.cmd.NvimTreeToggle";
          "<leader>er" = "vim.cmd.NvimTreeRefresh";
        };
      };
      plugins = {
        lspconfig = {
          enable = true;
          servers = {
            hls.enable = true;
            rust-analyzer.enable = true;
          };
        };
        treesitter = {
          enable = true;
          indent = true;
        };
        telescope = {
          enable = true;
          extensions = { manix.enable = true; };
        };
        nvim-tree = {
          enable = true;
          git.enable = true;
        };
        copilot.enable = true;
        luasnip.enable = true;
        nvim-cmp = {
          enable = true;
          snippet.luasnip.enable = true;
          sources = {
            copilot.enable = true;
            crates.enable = true;
            fish.enable = true;
            nvim_lsp.enable = true;
            treesitter.enable = true;
          };
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = {
              modes = [ "i" "s" ];
              action = ''
                function(fallback)
                    local luasnip = require("luasnip")
                    if cmp.visible() then
                      cmp.select_next_item()
                    elseif luasnip.expandable() then
                      luasnip.expand()
                    elseif luasnip.expand_or_jumpable() then
                      luasnip.expand_or_jump()
                    elseif check_backspace() then
                      fallback()
                    else
                      fallback()
                    end
                  end
              '';
            };
            "<S-Tab>" = {
              modes = [ "i" "s" ];
              action = ''
                function(fallback)
                  local luasnip = require("luasnip")
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    fallback()
                  end
                end
              '';
            };
          };
        };
      };
      extraPlugins = [ pkgs.vimExtraPlugins.lsp-zero-nvim ];
    };

    home.packages = [ pkgs.neovide pkgs.nil ];
    home.file.".config/neovide/config.toml".text = ''
      neovim_bin = "${pkgs.neovim}/bin/nvim";
      vsync = true;
      idle = false;
      frame = "none";
    '';

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

          jnoortheen.nix-ide

          # Copilot
          github.copilot

          # Misc
          mkhl.direnv
          ms-vsliveshare.vsliveshare
          ms-vscode.live-server
          wakatime.vscode-wakatime

          github.vscode-github-actions
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
          {
            name = "vscode-wasm";
            publisher = "dtsvet";
            version = "1.4.1";
            sha256 = "sha256-zs7E3pxf4P8kb3J+5zLoAO2dvTeepuCuBJi5s354k0I=";
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
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "[nix]" = { "editor.defaultFormatter" = "brettm12345.nixfmt-vscode"; };
      };
    };
  };
}
