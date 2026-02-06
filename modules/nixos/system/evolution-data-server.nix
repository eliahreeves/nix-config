{
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "evolution-data-server";
  cfg = {
    services.gnome.evolution-data-server.enable = true;
  };
}
