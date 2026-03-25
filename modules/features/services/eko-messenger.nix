{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.eko-messenger = {pkgs, ...}: {
    imports = with self.modules.nixos;
      [
        postgres
        nginx
      ]
      ++ [
        inputs.eko-messenger.nixosModules.default
      ];

    services.eko-messenger = {
      enable = true;
      port = 1265;
      package = inputs.eko-messenger.packages.${pkgs.stdenv.hostPlatform.system}.firebase;
      domain = "https://messages.eko-app.com";
      authProvider = "firebase";
      firebaseServiceAccount = "/var/lib/eko-messenger/firebase.json";
      jwtSecret = "not-very-secret-key";
      logLevel = "debug";
    };

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
