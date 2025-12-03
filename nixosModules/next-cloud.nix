{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    next-cloud.enable = lib.mkEnableOption "Next Cloud";
  };
  config = lib.mkIf config.next-cloud.enable {
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
