{self, ...}: {
  flake.modules.nixos.firefox = {
    home-manager.sharedModules = [self.modules.homeManager.firefox];
  };
  flake.modules.homeManager.firefox = {
    pkgs,
    config,
    ...
  }: let
    sharedConfig = self.lib.browserCommon {inherit pkgs;};
  in {
    programs.firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";
      profiles =
        sharedConfig.profiles
        // {
          default =
            (sharedConfig.profiles.default or {})
            // {
              settings = {
                "browser.sessionstore.resume_from_crash" = false;
                # AI
                "browser.ai.control.default" = "blocked";
                "browser.ai.control.linkPreviewKeyPoints" = "blocked";
                "browser.ai.control.pdfjsAltText" = "blocked";
                "browser.ai.control.sidebarChatbot" = "blocked";
                "browser.ai.control.smartTabGroups" = "blocked";
                "extensions.ml.enabled" = false;
                "pdfjs.enableAltText" = false;
                "browser.ml.chat.enabled" = false;
                "browser.ml.chat.page" = false;
                "browser.ml.linkPreview.enabled" = false;
                "browser.tabs.groups.smart.enabled" = false;
                "browser.tabs.groups.smart.userEnabled" = false;
              };
            };
        };
      policies =
        sharedConfig.policies
        // {
          PromptForDownloadLocation = true;
        };
    };
    xdg.mimeApps = let
      value = "firefox.desktop";

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
