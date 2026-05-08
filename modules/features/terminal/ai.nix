{self, ...}: {
  flake.modules.nixos.ai = {
    home-manager.sharedModules = [self.modules.homeManager.ai];
  };
  flake.modules.homeManager.ai = {pkgs, ...}: {
    programs.opencode = {
      enable = true;
      settings = {
        plugin = ["opencode-gemini-auth@latest"];
      };
    };
    home.sessionVariables.OPENCODE_EXPERIMENTAL_PLAN_MODE = "true";
    home.packages = with pkgs; [
      gemini-cli
      cursor-cli
    ];
    programs.git = {ignores = [".opencode/" ".cursor/"];};
  };
}
