{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nimh-networking.enable = lib.mkEnableOption "nimh-networking";
  };
  config = lib.mkIf config.nimh-networking.enable {
    networking.firewall.allowedTCPPorts = [80 443];

    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;

      commonHttpConfig = ''
        limit_req_zone $binary_remote_addr zone=login:10m rate=10r/m;
      '';

      virtualHosts."nimhphotos.tplinkdns.com" = {
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

    security.acme = {
      acceptTerms = true;
      defaults.email = "beomdoden@gmail.com";
    };
  };
}
