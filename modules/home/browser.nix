{ inputs, ... }:
{
  imports = [ inputs.zen.homeModules.beta ];

  programs.zen-browser = {
    enable = true;

    policies.ExtensionSettings =
      builtins.mapAttrs
        (_: slug: {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
        })
        {
          "uBlock0@raymondhill.net" = "ublock-origin";
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
          "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = "user-agent-string-switcher";
          "enhancerforyoutube@maximerf.addons.mozilla.org" = "enhancer-for-youtube";
        };
  };
}
