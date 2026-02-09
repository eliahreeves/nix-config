{
  config,
  helpers,
  pkgs,
  ...
}:
helpers.mkModule config {
  name = "vlc";
  cfg = {
    home.packages = with pkgs; [vlc];
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "video/mp4" = ["vlc.desktop"];
        "video/mpeg" = ["vlc.desktop"];
        "video/quicktime" = ["vlc.desktop"];
        "video/x-matroska" = ["vlc.desktop"];
        "video/x-flv" = ["vlc.desktop"];
        "video/x-msvideo" = ["vlc.desktop"];
        "video/x-ms-wmv" = ["vlc.desktop"];
        "video/webm" = ["vlc.desktop"];
        "audio/mpeg" = ["vlc.desktop"];
        "audio/x-wav" = ["vlc.desktop"];
        "audio/ogg" = ["vlc.desktop"];
        "audio/x-vorbis+ogg" = ["vlc.desktop"];
        "audio/flac" = ["vlc.desktop"];
        "audio/mp4" = ["vlc.desktop"];
        "audio/aac" = ["vlc.desktop"];
        "audio/x-matroska" = ["vlc.desktop"];
        "audio/x-m4b" = ["vlc.desktop"];
      };
    };
  };
}
