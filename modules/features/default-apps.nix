{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.default-apps = {pkgs, ...}: {
    imports = with self.modules.nixos; [
      helpers
      zen-browser
    ];
    environment.systemPackages = with pkgs; [
      vlc
      nautilus
      loupe
      gnome-text-editor
      papers
      file-roller
    ];

    home-manager.sharedModules = [self.modules.homeManager.default-apps];
  };
  flake.modules.homeManager.default-apps = {
    pkgs,
    lib,
    helpers,
    ...
  }: let
    mimeAssoc = lib.genAttrs;
    getEntry = helpers.getDesktopEntry;
    files = mimeAssoc ["inode/directory"] (_: getEntry pkgs.nautilus);
    documents = mimeAssoc ["application/pdf"] (_: getEntry pkgs.papers);

    text = mimeAssoc [
      "text/plain"
      "text/markdown"
      "text/x-readme"
      "text/x-log"
    ] (_: getEntry pkgs.gnome-text-editor);
    images = mimeAssoc [
      "image/png"
      "image/jpeg"
      "image/bmp"
      "image/gif"
      "image/tiff"
      "image/webp"
      "image/svg+xml"
      "image/x-tga"
    ] (_: getEntry pkgs.loupe);

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
    ] (_: getEntry pkgs.file-roller);

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
    ] (_: getEntry inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default);

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
    ] (_: getEntry pkgs.vlc);
    defaults = videos // browser // images // files // documents // text // archives;
  in {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = defaults;
      associations.added = defaults;
    };
  };
}
