# Gaming configuration shared by all hosts (Steam, Proton, GameMode, controllers).
{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    # Community Proton build with extra patches/codecs; selectable per game in
    # Steam under Properties > Compatibility as "GE-Proton".
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    # `protontricks` for running winetricks against a game's Proton prefix.
    protontricks.enable = true;
    # Translate X11 input events from the (Xwayland) Steam client into uinput
    # events so Steam Input works properly under Wayland compositors.
    extest.enable = true;
  };

  # Micro-compositor from SteamOS. Useful for games that misbehave with
  # scaling, fullscreen, or refresh rate: add `gamescope -f -- %command%` to a
  # game's launch options.
  programs.gamescope.enable = true;

  # Applies CPU governor / niceness tweaks while a game is running.
  # Add `gamemoderun %command%` to a game's launch options in Steam.
  programs.gamemode = {
    enable = true;
    settings.general.renice = 10;
  };
  users.users.gavin.extraGroups = [ "gamemode" ];

  # Bluetooth driver for Xbox controllers.
  hardware.xpadneo.enable = true;

  # Some games (and Proton in general) need far more memory mappings than the
  # kernel default. This is the value SteamOS ships with.
  boot.kernel.sysctl."vm.max_map_count" = 2147483642;

  environment.systemPackages = with pkgs; [
    # In-game FPS / temperature / frametime overlay. Launch option:
    # `mangohud %command%`
    mangohud
  ];
}
