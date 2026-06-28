{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.zen-browser = {
    key = "zen-browser";
    home-manager.sharedModules = [self.modules.homeManager.zen-browser];
  };
  flake.modules.homeManager.zen-browser = {pkgs, ...}: let
    sharedConfig = self.lib.browserCommon {inherit pkgs;};
  in {
    imports = [
      inputs.zen-browser.homeModules.beta
    ];
    programs.zen-browser = {
      enable = true;
      profiles = sharedConfig.profiles;
      policies = sharedConfig.policies;
    };
  };
}
