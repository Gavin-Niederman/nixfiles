# Noctalia shell, configured as a left-hand sidebar.
# https://docs.noctalia.dev/noctalia/configuration/
{ ... }:

{
  programs.noctalia = {
    enable = true;
    settings = {
      bar.default = {
        position = "left";
        enabled = true;
        reserve_space = true;
      };
    };
  };

  # Floating settings window + let noctalia activate windows / notification actions.
  programs.niri.extraConfig = ''
    window-rule {
      match app-id="dev.noctalia.Noctalia"
      open-floating true
      default-column-width { fixed 1080; }
      default-window-height { fixed 920; }
    }

    debug {
      honor-xdg-activation-with-invalid-serial
    }
  '';
}
