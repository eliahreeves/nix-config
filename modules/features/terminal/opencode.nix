{self, ...}: {
  flake.modules.nixos.opencode = {
    home-manager.sharedModules = [self.modules.homeManager.opencode];
  };
  flake.modules.homeManager.opencode = {...}: {
    programs.opencode = {
      enable = true;
      settings = {
        plugin = ["opencode-gemini-auth@latest"];
      };
    };
  };
}
