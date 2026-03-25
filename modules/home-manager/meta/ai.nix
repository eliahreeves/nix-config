{
  self,
  inputs,
  ...
}: {
  flake.modules.homeManager.ai = {
    config,
    pkgs,
    ...
  }: {
    imports = [self.modules.homeManager.opencode];
    home.packages = with pkgs; [
      qwen-code
      gemini-cli
    ];
  };
}
