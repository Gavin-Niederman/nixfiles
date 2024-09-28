{ pkgs, ... }:

{
  programs.nixneovim = {
    enable = true;
    colorschemes.gruvbox-nvim.enable = true;
    extraConfigLua = ''
              vim.o.number = true;
              vim.o.relativenumber = true;
              vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true });
      	require("toggleterm").setup{
      		open_mapping = [[<C-/>]],
      	}
    '';
    mappings = {
      normal = {
        "<leader>ff" = "vim.cmd.NvimTreeFocus";
        "<leader>fe" = "vim.cmd.NvimTreeToggle";
        "<leader>fr" = "vim.cmd.NvimTreeRefresh";
        # "<leader>jj" = "vim.cmd('Telescope find_files')";
      };
    };
    augroups = {
      dashboard = {
        autocmds = [{
          event = "VimEnter";
          pattern = "*";
          luaCallback = ''
            require('dashboard').setup {
              
            }
          '';
        }];
      };
    };
    plugins = {
      lspconfig = {
        enable = true;
        servers = {
          rust-analyzer.enable = true;
          nil.enable = true;
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
      dashboard.enable = true;
      todo-comments.enable = true;
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
                  local check_backspace = function()
                    local col = vim.fn.col "." - 1
                    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
                  end
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
      nvim-autopairs.enable = true;
    };
    extraPlugins = with pkgs; [
      vimExtraPlugins.lsp-zero-nvim
      vimExtraPlugins.nvim-toggleterm-lua
      vimExtraPlugins.tree-sitter-just
      direnv-vim
    ];
  };

  home.packages = with pkgs; [ neovide nil nixfmt-classic wl-clipboard ];
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

        bbenoist.nix
        brettm12345.nixfmt-vscode

        thenuprojectcontributors.vscode-nushell-lang

        yzhang.markdown-all-in-one

        svelte.svelte-vscode
        astro-build.astro-vscode
        bradlc.vscode-tailwindcss
        dbaeumer.vscode-eslint

        ms-vscode.cpptools
        skellock.just

        vadimcn.vscode-lldb

        jnoortheen.nix-ide

        # Copilot
        github.copilot

        # Misc
        mkhl.direnv
        # ms-vsliveshare.vsliveshare
        # ms-vscode.live-server
        usernamehw.errorlens
        iliazeus.vscode-ansi
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "dependi";
          publisher = "fill-labs";
          version = "0.7.8";
          sha256 = "sha256-UxLpn86U5EI+qRUpEXt+ByirtCwOUknRwTwpfCF+tqQ=";
        }
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
          name = "wgsl";
          publisher = "PolyMeilex";
          version = "0.1.16";
          sha256 = "sha256-0EcV80N8u3eQB74TNedjM5xbQFY7avUu3A8HWi7eZLk=";
        }
        {
          name = "wgsl-analyzer";
          publisher = "wgsl-analyzer";
          version = "0.8.1";
          sha256 = "sha256-ckclcxdUxhjWlPnDFVleLCWgWxUEENe0V328cjaZv+Y=";
        }
        {
          name = "linkerscript";
          publisher = "zixuanwang";
          version = "1.0.4";
          sha256 = "sha256-9w9fpMeewfVQIxRljyyxrjVz2EUJ9e9q1tz967tR1lU=";
        }
        {
          name = "vscode-twoslash";
          publisher = "Orta";
          version = "1.0.2";
          sha256 = "sha256-fuad6fG0RqLMSAfJVTzMp4eGOSDb95Y45AmoGD6jL70=";
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
      "rust-analyzer.server.path" = "rust-analyzer";
      "rust-analyzer.check.command" = "clippy";
      "workbench.settings.openDefaultKeybindings" = true;
      "window.zoomLevel" = 2;
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.cursorBlinking" = "smooth";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "[nix]" = { "editor.defaultFormatter" = "brettm12345.nixfmt-vscode"; };
      "codesnap.showWindowControls" = false;
      "errorLense.fontFamily" = "FiraCode Nerd Font Mono";
      "cSpell.enabledLanguageIds" =
        [ "asciidoc" "html" "markdown" "plaintext" "text" ];
    };
  };
}
