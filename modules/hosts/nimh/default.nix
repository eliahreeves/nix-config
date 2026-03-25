{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.nimh = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.modules.nixos.nimhConfiguration];
  };
}
