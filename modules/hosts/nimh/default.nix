{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.nimh = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.nimhConfiguration];
  };
}
