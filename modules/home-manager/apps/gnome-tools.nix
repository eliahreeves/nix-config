{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "gnome-tools";
  cfg = {
    home.packages = with pkgs; [
      loupe
      papers
      gnome-disk-utility
      gnome-mines
      warp
      evolution
    ];
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = ["org.gnome.Papers.desktop"];

        "image/png" = ["org.gnome.Loupe.desktop"];
        "image/jpeg" = ["org.gnome.Loupe.desktop"];
        "image/bmp" = ["org.gnome.Loupe.desktop"];
        "image/gif" = ["org.gnome.Loupe.desktop"];
        "image/tiff" = ["org.gnome.Loupe.desktop"];
        "image/webp" = ["org.gnome.Loupe.desktop"];
        "image/svg+xml" = ["org.gnome.Loupe.desktop"];
        "image/x-tga" = ["org.gnome.Loupe.desktop"];
      };
    };
  };
}
