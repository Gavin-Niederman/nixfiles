{ ... }:

{
  config = {
    xdg.mime.enable = true;
    xdg.icons.enable = true;
    services.upower.enable = true;

    services.keyd = {
      enable = true;
      keyboards.default.settings = {
        main = { capslock = "overload(control, esc)"; };
      };
    };
  };
}
