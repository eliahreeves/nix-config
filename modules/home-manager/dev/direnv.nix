{
  self,
  inputs,
  ...
}: {
  flake.modules.homeManager.direnv = {config, ...}: {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
