{...}: {
  flake.modules.nixos.postgres = {pkgs, ...}: {
    key = "postgres.key";
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_17;
    };
  };
}
