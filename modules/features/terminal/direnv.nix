{self, ...}: {
  flake.modules.nixos.direnv = {
    home-manager.sharedModules = [self.modules.homeManager.direnv];
  };
  flake.modules.homeManager.direnv = {...}: {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
