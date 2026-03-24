{
  self,
  inputs,
  ...
}: {
  flake.homeManagerModules.direnv = {config, ...}: {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
