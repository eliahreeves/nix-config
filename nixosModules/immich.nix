{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    immich.enable = lib.mkEnableOption "Enable immich";
  };
  config = lib.mkIf config.immich.enable {
    services.immich = {
      enable = true;
      openFirewall = true;
      database.enable = true;
      mediaLocation = "/srv/immich/library/";
    };
    services.postgresql = {
      enable = true;
      dataDir = "/srv/immich/postgres/";
      package = pkgs.postgresql_14;
    };
  };
}
