{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.trading = {config, ...}: {
    imports = with self.modules.nixos;
      [
        sops
      ]
      ++ [
        inputs.algo-ranch.nixosModules.default
      ];

    sops = {
      secrets."alpaca/key" = {};
      secrets."alpaca/secret" = {};
    };

    sops.templates."alpaca-api".content = ''
      ALPACA_API_KEY=${config.sops.placeholder."alpaca/key"}
      ALPACA_API_SECRET=${config.sops.placeholder."alpaca/secret"}
    '';

    services.trading-bot = {
      enable = true;
      environmentFile = config.sops.templates."alpaca-api".path;
    };
  };
}
