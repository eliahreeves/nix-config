{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  mkLockedAttrs = builtins.mapAttrs (_: value: {
    Value = value;
    Status = "locked";
  });

  mkPluginUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";

  mkExtensionEntry = {
    id,
    pinned ? false,
  }: let
    base = {
      install_url = mkPluginUrl id;
      installation_mode = "force_installed";
    };
  in
    if pinned
    then base // {default_area = "navbar";}
    else base;

  mkExtensionSettings = builtins.mapAttrs (_: entry:
    if builtins.isAttrs entry
    then entry
    else mkExtensionEntry {id = entry;});
in {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  options.zen-browser.enable = lib.mkEnableOption "Enable Zen";
  config = lib.mkIf config.zen-browser.enable {
    programs.zen-browser = {
      enable = true;
      suppressXdgMigrationWarning = true;
      profiles.default = {
        search = {
          force = true;
          default = "StartPage";
          privateDefault = "StartPage";
          engines = {
            "Nix Packages" = {
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
              definedAliases = ["@pkgs"];
            };
            "Nix Options" = {
              urls = [
                {
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
                }
              ];
              definedAliases = ["@nop"];
            };
            "Home Manager Options" = {
              urls = [
                {
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
                }
              ];
              definedAliases = ["hmop"];
            };
            "Google Maps" = {
              urls = [
                {
                  template = "http://maps.google.com";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@maps" "@gmaps"];
            };
            "StartPage" = {
              urls = [
                {
                  template = "https://www.startpage.com/sp/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@startpage" "@sp" "@pp"];
            };
            "ddg" = {
              urls = [
                {
                  template = "https://duckduckgo.com";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@duck" "@ddg" "@dck" "@dckk"];
            };
          };
        };
      };
      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        SanitizeOnShutdown = {
          FormData = true;
          Cache = true;
        };
        ExtensionSettings = mkExtensionSettings {
          "78272b6fa58f4a1abaac99321d503a20@proton.me" = mkExtensionEntry {
            id = "proton-pass";
            pinned = true;
          };
          "uBlock0@raymondhill.net" = "ublock-origin";
          "{0814291e-c531-4741-a8e7-9a3e8f62bf71}" = "remove-youtube-tracking";
          "{4590d8b8-3569-46e3-a571-cabfbaeab2c1}" = "no-youtube-shorts";
          "{74145f27-f039-47ce-a470-a662b129930a}" = "clearurls";
          "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
          "{ef9e884b-b6d8-4544-b0de-82c46c5e95de}" = "sponsorblock";
          "@searchengineadremover" = "searchengineadremover";
        };
        Preferences = mkLockedAttrs {
          "browser.tabs.warnOnClose" = false;
          "browser.tabs.hoverPreview.enabled" = true;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.topsites.contile.enabled" = false;
        };
      };
    };
    xdg.mimeApps = let
      value = let
        zen-browser = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta; # or twilight
      in
        zen-browser.meta.desktopFileName;

      associations = builtins.listToAttrs (map (name: {
          inherit name value;
        }) [
          "application/x-extension-shtml"
          "application/x-extension-xhtml"
          "application/x-extension-html"
          "application/x-extension-xht"
          "application/x-extension-htm"
          "x-scheme-handler/unknown"
          "x-scheme-handler/mailto"
          "x-scheme-handler/chrome"
          "x-scheme-handler/about"
          "x-scheme-handler/https"
          "x-scheme-handler/http"
          "application/xhtml+xml"
          "application/json"
          "text/plain"
          "text/html"
        ]);
    in {
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
