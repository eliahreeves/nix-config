{
  pkgs,
  lib,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "minecraft";
  cfg = {
    home.packages = with pkgs; [prismlauncher];
  };
}
