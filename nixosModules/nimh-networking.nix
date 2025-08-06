{
  pkgs,
  lib,
  config,
  ...
}: let
  nimhphotos = pkgs.writeShellScript "nimhphotos.sh" ''
      #!/usr/bin/env bash
    echo url="https://www.duckdns.org/update?domains=nimhphotos&token=1999df90-571b-4457-ace2-03f3f074ac34&ip=" | curl -k -o /tmp/duck.log -K -
  '';
in {
  options = {
    nimh-networking.enable = lib.mkEnableOption "nimh-networking";
  };
  config = lib.mkIf config.nimh-networking.enable {
    services.cron = {
      enable = true;
      systemCronJobs = [
        "*/5 * * * *      ${nimhphotos} >/dev/null 2>&1"
      ];
    };
    networking.firewall.allowedTCPPorts = [80 443];

    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;

      commonHttpConfig = ''
        limit_req_zone $binary_remote_addr zone=login:10m rate=10r/m;
      '';

      virtualHosts."nimhphotos.duckdns.org" = {
        enableACME = true;
        forceSSL = true;

        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:2283/";
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
