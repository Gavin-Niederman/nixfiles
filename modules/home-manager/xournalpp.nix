{
  pkgs,
  lib,
  config,
  ...
}:

# Xournal++ set up to look and feel like Rnote: a single vertical tool
# strip, no menubar/sidebar, monochrome (Lucide) icons, catppuccin macchiato
# palette and dark paper, plus shape recognition and stroke stabilisation on.
#
# The toolbar layout and palette are plain files and are managed here.
# settings.xml is rewritten by the app whenever anything changes in
# Preferences, so it is *not* symlinked; instead the activation script below
# pins the handful of keys we care about and leaves everything else alone.
let
  toolbarId = "rnote-like";

  paletteFile = "xournalpp/palettes/catppuccin-macchiato.gpl";
  palettePath = "${config.xdg.configHome}/${paletteFile}";

  # catppuccin macchiato
  base = "#24273a";
  mantle = "#1e2030";
  sky = "#91d7e3";
  # aarrggbb, as the tool/button config blocks store it: catppuccin `text`.
  defaultToolColor = "ffcad3f5";

  # Xournal++ stores colours as decimal ARGB.
  argbA = alpha: hex: toString (alpha * 16777216 + lib.fromHexString (lib.removePrefix "#" hex));
  argb = argbA 255;

  # Local patches (see each file's header):
  # - canvas-alpha: translucent canvas and on-screen paper, so the window is
  #   acrylic like every other one (see theme.nix)
  # - space-pan: hold space to pan with the hand tool
  xournalpp = pkgs.xournalpp.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ./xournalpp-canvas-alpha.patch
      ./xournalpp-space-pan.patch
    ];
  });

  # Keys pinned in settings.xml on every activation.
  settings = {
    selectedToolbar = toolbarId;
    menubarVisible = "false";
    showSidebar = "false";
    defaultViewModeAttributes = "showToolbar";
    fullscreenViewModeAttributes = "goFullscren,showToolbar";
    iconTheme = "iconsLucide";
    themeVariant = "useSystem";
    stylusCursorType = "dot";
    colorPalette = palettePath;
    # The void around pages: fully transparent, so the acrylic window
    # background (theme.nix, 70% base) shows through with niri's blur and
    # grain behind it. GTK composites the canvas widget as a group over the
    # window background, so giving the void its own alpha would stack on top
    # of that (0.7 over 0.7 = 0.91). Needs the alpha patch above.
    backgroundColor = argbA 0 base;
    # Used both for selection boxes and the 2px frame Xournal++ always draws
    # around the current page; the default is pure red.
    selectionBorderColor = argb sky;
    # New pages: dark dotted paper, like Rnote's default.
    pageTemplate = lib.concatStringsSep "&#10;" [
      "xoj/template"
      "copyLastPageSettings=true"
      "size=595.275591x841.889764"
      "backgroundType=dotted"
      "backgroundColor=${base}"
      ""
    ];
    # Shape recognition: snap recognised lines/shapes to axes and grid.
    snapRecognizedShapesEnabled = "true";
    snapRotation = "true";
    # Drawing straight sideways/diagonally switches that stroke to the
    # ruler/rectangle tool: the closest thing to hold-to-straighten.
    drawDirModsEnabled = "true";
    # Stabiliser: small deadzone, no averaging lag.
    stabilizerPreprocessor = "1"; # deadzone
    stabilizerDeadzoneRadius = "1.3";
    stabilizerAveragingMethod = "0";
    stabilizerCuspDetection = "true";
    stabilizerFinalizeStroke = "true";
  };

  # sed replacement text: escape the delimiter, `&` and backslashes.
  sedEscape = lib.escape [
    "\\"
    "|"
    "&"
  ];
  pinSetting = name: value: ''
    if grep -q 'name="${name}"' "$f"; then
      sed -i 's|\(name="${name}" value="\)[^"]*|\1${sedEscape value}|' "$f"
    else
      sed -i 's|</settings>|  <property name="${name}" value="${sedEscape value}"/>\n</settings>|' "$f"
    fi
  '';
in
{
  home.packages = [ xournalpp ];

  xdg.configFile."xournalpp/toolbar.ini".text = ''
    # Managed by home-manager (modules/home-manager/xournalpp.nix).
    # Item names: see ${xournalpp}/share/xournalpp/ui/toolbar.ini
    #
    # Left: one vertical strip like Rnote's sidebar. DRAW is the shape
    # dropdown (ruler, rectangle, ellipse, arrow, spline, shape recogniser);
    # clicking the active shape again, or DEFAULT_TOOL, returns to freehand.
    #
    # Top: everything document/journal related, de-emphasised via the
    # #tbTop1 CSS below. There is no toolbar item for Preferences; F10
    # shows the menubar, which has it.

    [${toolbarId}]
    name=Rnote-like
    toolbarLeft1=PEN,ERASER,HIGHLIGHTER,SEPARATOR,DRAW,DEFAULT_TOOL,SELECT,HAND,SEPARATOR,UNDO,REDO,SEPARATOR,FINE,MEDIUM,THICK,SEPARATOR,COLOR(0),COLOR(1),COLOR(2),COLOR(3),COLOR(4),COLOR(5),COLOR(6),COLOR(7),COLOR_SELECT
    toolbarTop1=NEW,OPEN,SAVE,SAVEPDF,SEPARATOR,INSERT_NEW_PAGE,DELETE_CURRENT_PAGE,SEPARATOR,GOTO_BACK,PAGE_SPIN,GOTO_NEXT,SEPARATOR,LAYER,SPACER,ZOOM_OUT,ZOOM_FIT,ZOOM_IN,SEPARATOR,TOGGLE_TOUCH_DRAWING,PAIRED_PAGES,SHOW_SIDEBAR,FULLSCREEN
  '';

  # Toolbars carry their glade ids as CSS names. The left strip is packed a
  # little tighter so it fits a 1080p window without overflowing; the top
  # strip is secondary: smaller still, and dimmed until hovered.
  gtk.gtk3.extraCss = ''
    /* Xournal++ (xournalpp.nix): primary left strip. GtkToolbar items are
       homogeneous, so every item is as tall as the biggest one; strip all
       the theme's button sizing so the whole strip fits in 1080p. */
    #tbLeft1 {
      padding: 2px 0;
    }
    #tbLeft1 button {
      min-height: 0;
      min-width: 0;
      padding: 2px;
      margin: 0;
    }
    #tbLeft1 toolitem, #tbLeft1 box, #tbLeft1 image {
      margin: 0;
      padding: 0;
    }
    #tbLeft1 separator {
      margin: 1px 0;
    }

    /* Xournal++ (xournalpp.nix): secondary top toolbar */
    #tbTop1 {
      opacity: 0.55;
      padding: 0 4px;
      transition: opacity 150ms ease-out;
    }
    #tbTop1:hover {
      opacity: 1;
    }
    #tbTop1 button {
      min-height: 22px;
      min-width: 22px;
      padding: 2px;
    }
    #tbTop1 image {
      -gtk-icon-transform: scale(0.8);
    }
  '';

  # GIMP palette; COLOR(n) in the toolbar indexes into this list.
  xdg.configFile.${paletteFile}.text = ''
    GIMP Palette
    Name: Catppuccin Macchiato
    #
    202 211 245 Text
    237 135 150 Red
    245 169 127 Peach
    238 212 159 Yellow
    166 218 149 Green
    145 215 227 Sky
    138 173 244 Blue
    198 160 246 Mauve
    245 189 230 Pink
    139 213 202 Teal
    183 189 248 Lavender
    165 173 203 Subtext0
    36  39  58  Base
  '';

  home.activation.xournalppSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    f="${config.xdg.configHome}/xournalpp/settings.xml"
    if [[ -v DRY_RUN ]]; then
      echo "Would pin Xournal++ settings in $f"
    else
      if [[ ! -f "$f" ]]; then
        mkdir -p "$(dirname "$f")"
        printf '%s\n' \
          '<?xml version="1.0" encoding="UTF-8"?>' \
          '<settings>' \
          '</settings>' > "$f"
      fi
      ${lib.concatStrings (lib.mapAttrsToList pinSetting settings)}

      # "Default tool" (DEFAULT_TOOL / Preferences > Tools) resets the pen to
      # the buttonConfig/default entry; make that catppuccin `text` rather
      # than black. The block is nested XML, so it is scoped with a sed
      # range: `default` is the first child of buttonConfig (sorted map).
      # Left alone until the app has written the block once.
      if grep -q '<data name="buttonConfig">' "$f"; then
        sed -i '/<data name="buttonConfig">/,/<\/data>/ s|\(<attribute name="color" type="hex" value="\)[^"]*|\1${defaultToolColor}|' "$f"
      fi
    fi
  '';
}
