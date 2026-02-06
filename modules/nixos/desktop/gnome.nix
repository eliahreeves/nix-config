{
  pkgs,
  lib,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "gnome";
  cfg = {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
  };
}
