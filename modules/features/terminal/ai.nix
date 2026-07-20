{self, ...}: {
  flake.modules.nixos.ai = {
    home-manager.sharedModules = [self.modules.homeManager.ai];
    persist.userDirectories = [
      ".cache/opencode"
      ".cache/cursor-compile-cache"
      ".config/opencode"
      ".local/state/opencode"
      ".local/share/opencode"
      ".cursor"
      ".config/cursor"
      ".local/share/cursor-agent"
    ];
  };
  flake.modules.homeManager.ai = {pkgs, ...}: {
    programs.opencode = {
      enable = true;
    };
    home.sessionVariables.OPENCODE_EXPERIMENTAL_PLAN_MODE = "true";
    home.packages = with pkgs; [
      gemini-cli
      cursor-cli
    ];
    programs.git = {ignores = [".opencode/" ".cursor/"];};
  };
}
