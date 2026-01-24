{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.eko-messenger.nixosModules.default
  ];

  options = {
    eko-messenger.enable = lib.mkEnableOption "Enable eko-messenger";
  };

  config = lib.mkIf config.eko-messenger.enable {
    services.eko-messenger = {
      enable = true;
      port = 1265;
      # package = inputs.eko-messenger.packages.${pkgs.system}.default;
      domain = "https://messages.eko-app.com";
      authProvider = "firebase";
      firebaseServiceAccount = "/var/lib/eko-messenger/firebase.json";
      jwtSecret = "not-very-secret-key";
    };

    nginx.enable = true;
    services.nginx = {
      virtualHosts = {
        "messages.eko-app.com" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://127.0.0.1:1265/";
              proxyWebsockets = true;
            };
          };
        };
      };
    };
  };
}
