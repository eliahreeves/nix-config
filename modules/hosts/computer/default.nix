{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.computer = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.computerConfiguration
      inputs.home-manager.nixosModules.default
      {home-manager.useGlobalPkgs = true;}
    ];
  };
}
