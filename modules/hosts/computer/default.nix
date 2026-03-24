{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.computer = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.computerConfiguration];
  };
}
