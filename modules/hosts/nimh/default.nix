{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.nimh = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.helpers
      self.modules.nixos.nimhConfiguration
      inputs.home-manager.nixosModules.default
      {home-manager.useGlobalPkgs = true;}
    ];
  };
}
