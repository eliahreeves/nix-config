{
  self,
  inputs,
  ...
}: {
  flake.homeManagerModules.ai = {
    config,
    pkgs,
    ...
  }: {
    imports = [self.homeManagerModules.opencode];
    home.packages = with pkgs; [
      qwen-code
      gemini-cli
    ];
  };
}
