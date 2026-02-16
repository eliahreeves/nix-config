{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "immich";
  cfg = {
    services.immich = {
      enable = true;
      openFirewall = true;
      mediaLocation = "/srv/immich/";
      database.enableVectors = false;
    };

    postgres.enable = true;

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
