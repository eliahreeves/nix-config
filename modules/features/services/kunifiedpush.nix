{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.kunifiedpush = {
    home-manager.sharedModules = [self.modules.homeManager.kunifiedpush];
  };

  flake.modules.homeManager.kunifiedpush = {
    imports = [
      inputs.kunifiedpush-flake.homeManagerModules.kunifiedpush
    ];
    services.kunifiedpush.enable = true;
  };
}
