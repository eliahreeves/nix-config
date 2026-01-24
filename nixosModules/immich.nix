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
      mediaLocation = "/srv/immich/";
    };

    services.postgresql = {
      enable = true;
      dataDir = "/srv/postgres/";
      package = pkgs.postgresql_14;
    };

    nginx.enable = true;
    services.nginx = {
      virtualHosts = {
        "nimhphotos.tplinkdns.com" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://[::1]:2283/";
              proxyWebsockets = true;
            };
            "/auth/login" = {
              extraConfig = ''
                limit_req zone=login burst=5 nodelay;
              '';
            };
          };
        };
      };
    };
  };
}
