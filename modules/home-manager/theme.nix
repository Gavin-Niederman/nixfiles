{ pkgs, lib, ... }:

let
  # Not used right now but kept for reference
  patched-capitaine = pkgs.capitaine-cursors.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      (builtins.toFile "nominal-size.patch" ''
        diff --git a/build.sh b/build.sh
        index e008e47..37c257c 100755
        --- a/build.sh
        +++ b/build.sh
        @@ -12,7 +12,7 @@ SPECS="$SRC/config"
         ALIASES="$SRC/cursor-aliases"
         SIZES=('1' '1.25' '1.5' '2' '2.5' '3' '4' '5' '6' '10')
         DPIS=('lo' 'tv' 'hd' 'xhd' 'xxhd' 'xxxhd')
        -SVG_DIM=24
        +SVG_DIM=21
         SVG_DPI=96
         
         # Truncates $SIZES based on the specified max DPI.
      '')
    ];

    buildPhase = ''
      HOME="$NIX_BUILD_ROOT" ./build.sh --max-dpi tv --type dark
    '';
    installPhase = ''
      install -dm 0755 $out/share/icons
      cp -pr dist/dark $out/share/icons/capitaine-cursors
    '';
  });
  # Acrylic look shared with Zed (editor.nix), kitty (applications.nix), Zen
  # (zen.nix) and Vesktop: the window background carries the alpha (70%, like
  # kitty's background_opacity / Zed's `b3`) and niri blurs + grains what is
  # behind it (niri.nix). Every surface stacked on the window is transparent
  # so the opacity stays uniform; sidebars get a slight dark tint to stay
  # distinguishable (Vesktop's Translucence does the same), and popups/menus
  # are near-opaque so they stay readable (they are separate surfaces niri
  # does not blur).
  acrylic =
    let
      base = "36, 39, 58"; # catppuccin macchiato base (#24273a)
      surface = "54, 58, 79"; # catppuccin macchiato surface0 (#363a4f)
      window = "rgba(${base}, 0.7)";
      sidebar = "rgba(0, 0, 0, 0.15)";
      popup = "rgba(${surface}, 0.9)";
    in
    {
      # GTK3 (Nemo, file chooser portal, ...) on top of catppuccin-gtk, which
      # bakes its colours into the selectors: everything it paints in `base`
      # (#24273a) becomes transparent so the window shows through, and
      # everything it paints in the darker `mantle` (#1e2030: toolbars, menu
      # bar, inactive pane) becomes the same dark tint as the sidebar. Menus,
      # popovers and tooltips are already opaque-ish in the theme and are
      # left alone (they are popup surfaces niri does not blur anyway).
      gtk3 = ''
        window.background, .background:not(.popup), .nemo-window {
          background-color: ${window};
        }

        /* Painted in `base` by the theme: same colour as the window */
        .view, iconview, treeview.view, textview, textview text, list,
        notebook, notebook > stack, scrolledwindow, viewport,
        paned > separator.wide, searchbar > revealer > box, .location-bar,
        actionbar > revealer > box, .csd filechooser,
        .nemo-window-pane, .nemo-search-bar {
          background-color: transparent;
        }

        /* Painted in `mantle` by the theme: keep it darker, as a tint */
        toolbar, .toolbar, .primary-toolbar, .inline-toolbar, menubar, .menubar,
        .titlebar, headerbar, box.vertical headerbar, statusbar,
        .sidebar, placessidebar, .sidebar list,
        .nemo-window .nemo-inactive-pane .view:not(:selected) {
          background-color: ${sidebar};
        }
      '';

      # GTK4 / libadwaita: the stylesheet references named colours, so
      # redefining them is enough (and, unlike selector rules at user
      # priority, does not stomp on apps that style `window` themselves,
      # e.g. ballad). Both spellings: `--vars` for libadwaita >= 1.6 / GTK
      # >= 4.16, `@define-color` for anything older.
      gtk4 =
        let
          colours = {
            window_bg_color = window;
            view_bg_color = "transparent";
            headerbar_bg_color = "transparent";
            headerbar_backdrop_color = "transparent";
            sidebar_bg_color = sidebar;
            sidebar_backdrop_color = sidebar;
            secondary_sidebar_bg_color = sidebar;
            secondary_sidebar_backdrop_color = sidebar;
            popover_bg_color = popup;
            dialog_bg_color = popup;
          };
          defines = lib.concatStringsSep "\n" (
            lib.mapAttrsToList (name: value: "@define-color ${name} ${value};") colours
          );
          vars = lib.concatStringsSep "\n" (
            lib.mapAttrsToList (
              name: value: "  --${builtins.replaceStrings [ "_" ] [ "-" ] name}: ${value};"
            ) colours
          );
        in
        ''
          ${defines}
          :root {
          ${vars}
          }
        '';
    };
in
{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 36;
  };

  home.packages =
    let
      allCatppuccin =
        map
          (
            flavor:
            pkgs.catppuccin-gtk.override {
              variant = flavor;
              accents = [ "sky" ];
            }
          )
          [
            "macchiato"
            "frappe"
            "latte"
            "mocha"
          ];
    in
    with pkgs;
    [
      adwaita-icon-theme
      morewaita-icon-theme
    ]
    ++ allCatppuccin;

  catppuccin = {
    kitty.enable = true;
    fuzzel.enable = true;
    flavor = "macchiato";
    accent = "sky";
  };

  # GTK apps follow the dark scheme everywhere: GTK3 via settings.ini,
  # GTK4/libadwaita via the settings portal (dconf).
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  gtk = {
    enable = true;

    cursorTheme = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 36;
    };

    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };

    # Same flavor as kitty; the acrylic GTK3 CSS above is written against
    # this theme's stylesheet. libadwaita apps ignore it and get the named
    # colour overrides instead.
    theme = {
      name = "catppuccin-macchiato-sky-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "macchiato";
        accents = [ "sky" ];
      };
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk3.extraCss = acrylic.gtk3;
    gtk4.extraCss = acrylic.gtk4;
  };
}
