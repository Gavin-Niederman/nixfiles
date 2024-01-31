{ pkgs, ... }:

{
  config = {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    hardware.pulseaudio.package = pkgs.pulseaudioFull;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;

    environment.systemPackages = with pkgs; [ pamixer pavucontrol ];
  };
}
