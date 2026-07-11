{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.machine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.helpers
      self.modules.nixos.machine-configuration
      self.modules.nixos.machine-hardware
      inputs.home-manager.nixosModules.default
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
        };
      }
    ];
  };
}
