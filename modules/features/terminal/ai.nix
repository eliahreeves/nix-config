{self, ...}: {
  flake.modules.homeManager.ai = {pkgs, ...}: {
    imports = [self.modules.homeManager.opencode];
    home.packages = with pkgs; [
      qwen-code
      gemini-cli
    ];
  };
}
