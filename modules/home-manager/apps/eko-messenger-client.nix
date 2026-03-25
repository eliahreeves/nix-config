{
  self,
  inputs,
  ...
}: {
  flake.modules.homeManager.eko-messenger-client = {
    pkgs,
    config,
    ...
  }: {
    home.packages = [
      inputs.eko-messenger-client.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
