{self, ...}: {
  flake.modules.nixos.default-apps = {
    imports = with self.modules.nixos; [
      vlc
      zen-browser
      helium
    ];

    home-manager.sharedModules = [self.modules.homeManager.default-apps];
  };
  flake.modules.homeManager.default-apps = {
    config,
    lib,
    pkgs,
    helpers,
    ...
  }: let
    appType = lib.types.submodule ({config, ...}: {
      options = {
        package = lib.mkOption {
          type = lib.types.nullOr lib.types.package;
          default = null;
          description = "Package providing the app; installed when set.";
        };
        entry = lib.mkOption {
          type = lib.types.str;
          default = helpers.getDesktopEntry config.package;
          defaultText = lib.literalExpression "helpers.getDesktopEntry package";
          description = "Desktop entry used for mime associations.";
        };
      };
    });
    apps = config.defaultApps;
    mimeAssoc = lib.genAttrs;
    files = mimeAssoc ["inode/directory"] (_: apps.file.entry);
    documents = mimeAssoc ["application/pdf"] (_: apps.doc.entry);

    text = mimeAssoc [
      "text/plain"
      "text/markdown"
      "text/x-readme"
      "text/x-log"
    ] (_: apps.text.entry);
    images = mimeAssoc [
      "image/png"
      "image/jpeg"
      "image/bmp"
      "image/gif"
      "image/tiff"
      "image/webp"
      "image/svg+xml"
      "image/x-tga"
    ] (_: apps.image.entry);

    archives = mimeAssoc [
      "application/zip"
      "application/x-zip-compressed"
      "application/x-tar"
      "application/x-compressed-tar"
      "application/x-bzip2"
      "application/x-gzip"
      "application/x-xz"
      "application/x-7z-compressed"
      "application/x-rar"
      "application/x-rar-compressed"
      "application/java-archive"
    ] (_: apps.archive.entry);

    browser = mimeAssoc [
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
      "text/html"
    ] (_: apps.browser.entry);

    videos = mimeAssoc [
      "video/mp4"
      "video/mpeg"
      "video/quicktime"
      "video/x-matroska"
      "video/x-flv"
      "video/x-msvideo"
      "video/x-ms-wmv"
      "video/webm"
      "audio/mpeg"
      "audio/x-wav"
      "audio/ogg"
      "audio/x-vorbis+ogg"
      "audio/flac"
      "audio/mp4"
      "audio/aac"
      "audio/x-matroska"
      "audio/x-m4b"
    ] (_: apps.video.entry);
    defaults = videos // browser // images // files // documents // text // archives;
  in {
    options.defaultApps = lib.mkOption {
      type = lib.types.attrsOf appType;
      default = {};
      description = "Default application for each role.";
    };

    config = {
      defaultApps = lib.mapAttrs (_: lib.mkDefault) {
        terminal.package = pkgs.foot;
        file.package = pkgs.nautilus;
        doc.package = pkgs.papers;
        video.package = pkgs.vlc;
        text.package = pkgs.vim;
        browser.entry = "helium.desktop";
        archive.package = pkgs.file-roller;
        image.package = pkgs.loupe;
      };

      home.packages =
        lib.filter (pkg: pkg != null)
        (lib.mapAttrsToList (_: app: app.package) apps);

      xdg.mimeApps = {
        enable = true;
        defaultApplications = defaults;
        associations.added = defaults;
      };
    };
  };
}
