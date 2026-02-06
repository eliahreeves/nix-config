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
      gnome-mines
      warp
      evolution
    ];
  };
}
