{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.postgres = {
    pkgs,
    lib,
    ...
  }: {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_17;
    };
  };
}
