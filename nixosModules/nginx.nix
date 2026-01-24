{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nginx.enable = lib.mkEnableOption "nginx";
  };
  config = lib.mkIf config.nginx.enable {
    networking.firewall.allowedTCPPorts = [80 443];

    services.nginx.virtualHosts."_" = {
      default = true;
      rejectSSL = true;
      locations."/".return = "404";
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
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "beomdoden@gmail.com";
    };
  };
}
