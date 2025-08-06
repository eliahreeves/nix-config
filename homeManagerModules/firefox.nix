{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options = {
    firefox.enable = lib.mkEnableOption "firefox";
  };

  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;
      policies = {
        FirefoxHome = {
          SponsoredTopSites = false;
          Pocket = false;
          Stories = false;
          SponsoredPocket = false;
          SponsoredStories = false;

          TopSites = false;
          Highlights = false;
          Snippets = false;
          # "Search": true | false,
          # "Locked": true | false
        };
        DisableTelemetry = true;
        OfferToSaveLogins = false;
        PromptForDownloadLocation = true;
        ExtensionSettings = with builtins; let
          extension = shortId: uuid: install_mode: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = install_mode;
            };
          };
        in
          listToAttrs [
            (extension "ublock-origin" "uBlock0@raymondhill.net" "force_install")
            (extension "proton-pass" "78272b6fa58f4a1abaac99321d503a20@proton.me" "normal_installed")
            (extension "sponsorblock" "sponsorBlocker@ajay.app" "force_install")
            (extension "dark-nivgvrv" "dd5f0c02-70f9-4e87-82fa-b4d4f8541518" "normal_installed")
          ];
        # To add additional extensions, find it on addons.mozilla.org, find
        # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
        # Then, download the XPI by filling it in to the install_url template, unzip it,
        # run `jq .browser_specific_settings.gecko.id manifest.json` or
        # `jq .applications.gecko.id manifest.json` to get the UUID
        # about:support#addons
      };
      profiles.default = {
        search = {
          force = true;
          default = "ddg";
          engines = {
            bing.metaData.hidden = true;
            ebay.metaData.hidden = true;
            nix-packages = {
              name = "Nix Packages";
              urls = [
                {
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
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };
            nix-home-manager = {
              name = "Nix Home Manager";
              urls = [
                {
                  template = "https://home-manager-options.extranix.com";
                  params = [
                    {
                      name = "release";
                      value = "master";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@nhm"];
            };
          };
        };
      };
    };
  };
}
