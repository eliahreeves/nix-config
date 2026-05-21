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
      signal-desktop
      nautilus
      loupe
      gnome-text-editor
      papers
    ];

    home-manager.sharedModules = [self.modules.homeManager.default-apps];
  };
  flake.modules.homeManager.default-apps = {
    pkgs,
    lib,
    helpers,
    ...
  }: let
    browserDesktop = helpers.getDesktopEntry inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
    videoDesktop = helpers.getDesktopEntry pkgs.vlc;
    signalDesktop = helpers.getDesktopEntry pkgs.signal-desktop;
    fileExplorer = helpers.getDesktopEntry pkgs.nautilus;
    imageViewer = helpers.getDesktopEntry pkgs.loupe;
    DocumentViewer = helpers.getDesktopEntry pkgs.papers;
    textDesktop = helpers.getDesktopEntry pkgs.gnome-text-editor;

    mimeAssoc = lib.genAttrs;

    signalMessaging = mimeAssoc [
      "x-scheme-handler/sgnl"
      "x-scheme-handler/signalcaptcha"
    ] (_: signalDesktop);

    files = mimeAssoc ["inode/directory"] (_: fileExplorer);
    documents = mimeAssoc ["application/pdf"] (_: DocumentViewer);

    text = mimeAssoc [
      "text/plain"
      "text/markdown"
      "text/x-readme"
      "text/x-log"
    ] (_: textDesktop);
    image = mimeAssoc [
      "image/png"
      "image/jpeg"
      "image/bmp"
      "image/gif"
      "image/tiff"
      "image/webp"
      "image/svg+xml"
      "image/x-tga"
    ] (_: imageViewer);

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
    ] (_: browserDesktop);

    video = mimeAssoc [
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
    ] (_: videoDesktop);
    defaults = video // browser // signalMessaging // image // files // documents // text;
  in {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = defaults;
      associations.added = defaults;
    };
  };
}
