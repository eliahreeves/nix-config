{
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "adwaita-qt";
  cfg = {
    qt = {
      enable = true;
      style = "adwaita-dark";
    };
  };
}
