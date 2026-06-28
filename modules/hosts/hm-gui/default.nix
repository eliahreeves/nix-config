{
  self,
  inputs,
  ...
}: {
  flake.homeConfigurations."hm-gui" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    modules = [
      self.modules.homeManager.hmGuiConfiguration
    ];
    extraSpecialArgs = {inherit self inputs;};
  };
}
