{
  # Sonora's CI pushes every nightly here, so it downloads instead of compiling.
  nix.settings = {
    extra-substituters = [ "https://sonora.cachix.org" ];
    extra-trusted-public-keys = [
      "sonora.cachix.org-1:qbPeDsvZPbwUWHpQS5Oe0bjz5oHAVscHem+MCzwrc9Q="
    ];
  };

  # Lets Spotify Connect find and reach Sonora: mDNS discovery and its listener.
  # The app is in modules/home/apps/sonora.nix.
  networking.firewall = {
    allowedUDPPorts = [ 5353 ];
    allowedTCPPorts = [ 39395 ];
  };
}
