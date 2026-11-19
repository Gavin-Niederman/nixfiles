{ pkgs, ... }:

{
  # nixpkgs changed the neovim provider defaults for stateVersion >= 26.05.
  # Adopt the new defaults explicitly; no configured plugin needs the
  # python3/ruby providers.
  programs.neovim = {
    withRuby = false;
    withPython3 = false;
  };

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
        autocmds = [
          {
            event = "VimEnter";
            pattern = "*";
            luaCallback = ''
              require('dashboard').setup {

              }
            '';
          }
        ];
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
        extensions = {
          manix.enable = true;
        };
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
            modes = [
              "i"
              "s"
            ];
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
            modes = [
              "i"
              "s"
            ];
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

  home.packages = with pkgs; [
    neovide
    nil
    nixfmt
    wl-clipboard
  ];
  home.file.".config/neovide/config.toml".text = ''
    neovim_bin = "${pkgs.neovim}/bin/nvim";
    vsync = true;
    idle = false;
    frame = "none";
  '';

  programs.vscode = {
    enable = true;

    mutableExtensionsDir = false;

    profiles.default = {
      extensions =
        with pkgs.vscode-extensions;
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

          # svelte.svelte-vscode
          astro-build.astro-vscode
          bradlc.vscode-tailwindcss
          dbaeumer.vscode-eslint
          esbenp.prettier-vscode

          skellock.just

          llvm-vs-code-extensions.vscode-clangd
          vadimcn.vscode-lldb

          jnoortheen.nix-ide

          ms-python.python
          ms-python.pylint

          # Copilot
          github.copilot

          # Misc
          mkhl.direnv
          # ms-vsliveshare.vsliveshare
          # ms-vscode.live-server
          usernamehw.errorlens
          iliazeus.vscode-ansi
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "svelte-vscode";
            publisher = "svelte";
            version = "109.10.0";
            sha256 = "sha256-Rpzcf0ioM7faDWG1xcEuz6GNzU1lHZsGxGgaKwC8SKk=";
          }
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
          {
            name = "arm";
            publisher = "dan-c-underwood";
            version = "1.7.4";
            sha256 = "sha256-gZBM980AoD+0wnfHXJK9sqCuuLtRY08JnO3Qdq/TRfc=";
          }
          {
            name = "ev3dev-browser";
            version = "1.2.1";
            publisher = "ev3dev";
            sha256 = "sha256-sFzGzUOHoKlVf7D1L7lYZ5uHl42uvYHfl5oRCoQfx6g=";
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
        "[nix]" = {
          "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
        };
        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[toml]" = {
          "editor.defaultFormatter" = "tamasfe.even-better-toml";
        };
        "codesnap.showWindowControls" = false;
        "errorLense.fontFamily" = "FiraCode Nerd Font Mono";
        "cSpell.enabledLanguageIds" = [
          "asciidoc"
          "html"
          "markdown"
          "plaintext"
          "text"
        ];
        "typescript.updateImportsOnFileMove.enabled" = "always";
      };
    };
  };

  programs.zed-editor = {
    enable = true;
    userSettings = let
      # Acrylic look: niri blurs what's behind the window (see the window
      # rules in niri.nix). Zed stacks its surfaces (window background ->
      # panels/editor -> tabs/gutter/terminal), so to get a uniform opacity
      # only the base `background` carries alpha and everything drawn on top
      # is fully transparent.
      opacity = "b3"; # 70%
      transparent = "#00000000";
      acrylic = { background, activeLine, selected, surface }: {
        "background.appearance" = "blurred";
        background = "${background}${opacity}";
        "title_bar.background" = transparent;
        "status_bar.background" = transparent;
        "toolbar.background" = transparent;
        "editor.background" = transparent;
        "editor.gutter.background" = transparent;
        "tab_bar.background" = transparent;
        "tab.inactive_background" = transparent;
        "tab.active_background" = transparent;
        "panel.background" = transparent;
        "terminal.background" = transparent;
        "editor.active_line.background" = activeLine;
        # List rows (project panel, pickers) are ghost elements; Gruvbox gives
        # their hover/selected states solid fills, so use translucent overlays.
        "ghost_element.hover" = activeLine;
        "ghost_element.active" = selected;
        "ghost_element.selected" = selected;
        # Popovers/menus stay near-opaque so they're readable over code
        "elevated_surface.background" = surface;
        "surface.background" = surface;
        # Project panel sticky-scroll headers (pinned ancestor dirs) are drawn
        # over the scrolling rows and Zed can't blur its own content, so they
        # must be opaque to hide the text beneath. Gruvbox leaves them unset
        # (falls back to black); use the base bg so they blend with the window.
        "panel.overlay_background" = background;
        "panel.overlay_hover" = builtins.substring 0 7 surface;
      };
    in {
      agent_ui_font_size = 16.0;
      cli_default_open_behavior = "existing_window";
      project_panel.dock = "left";
      outline_panel.dock = "left";
      collaboration_panel.dock = "left";
      git_panel.dock = "left";
      agent = {
        dock = "right";
        favorite_models = [ ];
        model_parameters = [ ];
      };
      icon_theme = "Material Icon Theme";
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
      base_keymap = "VSCode";
      ui_font_size = 14.0;
      buffer_font_size = 15;
      ui_font_family = "FiraCode Nerd Font Mono";
      theme = {
        mode = "system";
        light = "Gruvbox Light";
        dark = "Gruvbox Dark";
      };
      theme_overrides = {
        "Gruvbox Dark" = acrylic {
          background = "#282828";
          activeLine = "#ffffff14";
          selected = "#ffffff28";
          surface = "#3a3735e6";
        };
        "Gruvbox Light" = acrylic {
          background = "#fbf1c7";
          activeLine = "#00000014";
          selected = "#00000028";
          surface = "#ecddb4e6";
        };
      };
      format_on_save = "off";
      node = {
        path = "/home/gavin/.nix-profile/bin/node";
        npm_path = "/home/gavin/.nix-profile/bin/npm";
      };
      languages.TypeScript.language_servers = [ "typescript-language-server" ];
      ssh_connections = [{
        host = "homelab.tail2d22f6.ts.net";
        username = "homelab";
        args = [ ];
        projects = [{ paths = [ "/home/homelab/nixfiles" ]; }];
      }];
    };
  };
}
