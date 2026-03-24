{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.evolution-data-server = {...}: {
    services.gnome.evolution-data-server.enable = true;
  };
}
