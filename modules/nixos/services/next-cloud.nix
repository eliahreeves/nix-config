{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "next-cloud";
  cfg = {
    services.nextcloud = {
      package = pkgs.nextcloud32;
      enable = true;
      configureRedis = true;
      database.createLocally = true;

      hostName = "nimhfiles.duckdns.org";
      https = true;
      config = {
        adminpassFile = "/etc/nixos/secrets/nextcloud-admin-pass";
        dbtype = "pgsql";
      };
    };
  };
}
