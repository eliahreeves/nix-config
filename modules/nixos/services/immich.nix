{self, ...}: {
  flake.modules.nixos.immich = {...}: {
    imports = with self.modules.nixos; [postgres nginx];
    services.immich = {
      enable = true;
      openFirewall = true;
      mediaLocation = "/srv/immich/";
    };

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
