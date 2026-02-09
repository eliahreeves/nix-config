{
  config,
  pkgs,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "firefox";
  cfg = {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = ["firefox.desktop"];
        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];

        "x-scheme-handler/chrome" = ["firefox.desktop"];
        "application/x-extension-htm" = ["firefox.desktop"];
        "application/x-extension-html" = ["firefox.desktop"];
        "application/x-extension-shtml" = ["firefox.desktop"];
        "application/xhtml+xml" = ["firefox.desktop"];
        "application/x-extension-xhtml" = ["firefox.desktop"];
        "application/x-extension-xht" = ["firefox.desktop"];
      };
    };

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
            (extension "ublock-origin" "uBlock0@raymondhill.net" "normal_installed")
            (extension "proton-pass" "78272b6fa58f4a1abaac99321d503a20@proton.me" "normal_installed")
            (extension "sponsorblock" "sponsorBlocker@ajay.app" "normal_installed")
          ];
        # To add additional extensions, find it on addons.mozilla.org, find
        # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
        # Then, download the XPI by filling it in to the install_url template, unzip it,
        # run `jq .browser_specific_settings.gecko.id manifest.json` or
        # `jq .applications.gecko.id manifest.json` to get the UUID
        # about:support#addons
      };
      profiles.default = {
        settings = {
          "browser.sessionstore.resume_from_crash" = false;
        };
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
