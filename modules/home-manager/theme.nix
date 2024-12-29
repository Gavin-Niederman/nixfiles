{ pkgs, ... }:

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
in {
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 36;
  };

  home.packages = let
    allCatppuccin = map (flavor:
      pkgs.catppuccin-gtk.override {
        variant = flavor;
        accents = [ "sky" ];
      }) [ "macchiato" "frappe" "latte" "mocha" ];
  in with pkgs; [ adwaita-icon-theme morewaita-icon-theme ] ++ allCatppuccin;

  catppuccin = {
    flavor = "macchiato";
    accent = "sky";
  };

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

    # theme = {
    #   name = "catppuccin-macchiato-sky-standard";
    #   package = pkgs.catppuccin-gtk.override {
    #     variant = "macchiato";
    #     accents = [ "sky" ];
    #   };
    # };
  };
}
