{ pkgs, ... }:

{
  programs.zen-browser = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableAppUpdate = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      # Install extensions
      ExtensionSettings = let
        mkExtension = (pluginId: {
          installation_mode = "force_installed";
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
        });
        mkExtensions = builtins.mapAttrs (_: id: mkExtension id);
      in mkExtensions {
        "uBlock0@raymondhill.net" = "ublock-origin";
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "return-youtube-dislikes";
        "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = "styl-us";
        "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = "user-agent-string-switcher";
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
      };
    };
    profiles.default = {
      search = {
        force = true;
        default = "ddg";
        engines = let
          nixSnowflake =
            "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        in {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];
            icon = nixSnowflake;
            definedAliases = [ "nixpkgs" "np" ];
          };
          "Nix Options" = {
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];
            icon = nixSnowflake;
            definedAliases = [ "nixopts" "no" ];
          };
          "Home Manager Options" = {
            urls = [{
              template = "https://home-manager-options.extranix.com/";
              params = [
                {
                  name = "query";
                  value = "{searchTerms}";
                }
                {
                  name = "release";
                  value = "master"; # unstable
                }
              ];
            }];
            icon = nixSnowflake;
            definedAliases = [ "hms" "home" ];
          };
          "Noogle" = {
            urls = [{
              template = "https://noogle.dev/q";
              params = [{
                name = "term";
                value = "{searchTerms}";
              }];
            }];
            icon = nixSnowflake;
            definedAliases = [ "noogle" "ng" ];
          };
          bing.metaData.hidden = "true";
        };
      };
    };
  };
}