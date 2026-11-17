{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.eko-messenger = {
    pkgs,
    config,
    ...
  }: {
    imports = with self.modules.nixos;
      [
        postgres
        nginx
        sops
      ]
      ++ [
        inputs.eko-messenger.nixosModules.default
      ];
    sops = {
      secrets."eko-messenger/supabase_db_url" = {};
      secrets."eko-messenger/vapid_public_key" = {};
      secrets."eko-messenger/vapid_private_key" = {};
      secrets."eko-messenger/apns_private_key" = {};
    };

    sops.templates."eko-messenger.env".content = ''
      SUPABASE_DB_URL=${config.sops.placeholder."eko-messenger/supabase_db_url"}
      VAPID_PUBLIC_KEY=${config.sops.placeholder."eko-messenger/vapid_public_key"}
      VAPID_PRIVATE_KEY=${config.sops.placeholder."eko-messenger/vapid_private_key"}
      APNS_PRIVATE_KEY=${config.sops.placeholder."eko-messenger/apns_private_key"}
    '';

    services.eko-messenger = {
      enable = true;
      port = 1265;
      domain = "https://messages.eko-app.com";
      databaseUrl = "postgresql:///eko_messenger?host=/run/postgresql&user=eko_messenger";
      jwtJwksUrl = "https://nkwizistugahxfwdwtwg.supabase.co/auth/v1/.well-known/jwks.json";
      environmentFile = config.sops.templates."eko-messenger.env".path;
      logLevel = "debug";
      apns = {
        teamId = "7ZD8Y5HH26";
        keyId = "49R3DYSG93";
        bundleId = "com.example.untitledApp";
        sandbox = true;
      };
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
