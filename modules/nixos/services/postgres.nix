{
  pkgs,
  config,
  helpers,
  lib,
  ...
}:
helpers.mkModule config {
  name = "postgres";
  cfg = {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_17;
    };
  };
}
