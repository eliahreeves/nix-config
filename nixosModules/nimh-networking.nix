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

    systemd.services.updatedns = {
      path = [pkgs.curl pkgs.jq pkgs.bind pkgs.coreutils];
      description = "Run update every 10 minutes";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "/usr/bin/updatedns.sh";
      };
    };

    systemd.timers.updatedns = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "5min";
        OnUnitActiveSec = "10min";
        AccuracySec = "5min";
      };
    };

    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      clientMaxBodySize = "15G";

      commonHttpConfig = ''
        limit_req_zone $binary_remote_addr zone=login:10m rate=10r/m;
      '';

      virtualHosts = {
        "nimhphotos.duckdns.org" = {
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
        "nimhfiles.duckdns.org" = {
          enableACME = true;
          forceSSL = true;
        };
      };
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "beomdoden@gmail.com";
    };
  };
}
