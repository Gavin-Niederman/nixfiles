{ pkgs, ... }:
{
  # Fcitx5 handles text input for every app that speaks an input method
  # protocol, which also gives GTK4 apps like Ghostty their Compose key back:
  # since 4.20, GTK4 on Wayland leaves Compose to the input method.
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      # Apps reach Fcitx5 through niri, so GTK_IM_MODULE and QT_IM_MODULE stay unset.
      waylandFrontend = true;

      addons = [
        pkgs.fcitx5-mozc
        (pkgs.catppuccin-fcitx5.override { withRoundedCorners = true; })
      ];

      # These are written read-only, so changes made in fcitx5-configtool do not stick.
      settings = {
        inputMethod = {
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            # What the trigger key switches to, from the first item below.
            DefaultIM = "mozc";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "mozc";
        };

        globalOptions = {
          # Replaces the default Ctrl+Space and Zenkaku/Hankaku triggers.
          "Hotkey/TriggerKeys"."0" = "Super+space";
          # Super+Space switches input method groups by default. Empty unbinds it.
          "Hotkey/EnumerateGroupForwardKeys" = { };
          "Hotkey/EnumerateGroupBackwardKeys" = { };
        };

        addons.classicui.globalSection = {
          Theme = "catppuccin-mocha-mauve";
          # Keeps the theme above instead of following the light/dark setting.
          UseDarkTheme = false;
        };
      };
    };
  };
}
