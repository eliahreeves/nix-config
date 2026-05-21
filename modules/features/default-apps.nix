{self, ...}: {
  flake.modules.nixos.default-apps = {helpers, ...}: {
    imports = with self.modules.nixos; [
      zen-browser
    ];
    environment.systemPackages = map (a: a.package) (builtins.attrValues helpers.apps);

    home-manager.sharedModules = [self.modules.homeManager.default-apps];
  };
  flake.modules.homeManager.default-apps = {
    lib,
    helpers,
    ...
  }: let
    mimeAssoc = lib.genAttrs;
    apps = helpers.apps;
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
    xdg.mimeApps = {
      enable = true;
      defaultApplications = defaults;
      associations.added = defaults;
    };
  };
}
