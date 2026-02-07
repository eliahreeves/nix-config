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
  };
}
