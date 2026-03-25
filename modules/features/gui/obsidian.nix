{
  self,
  inputs,
  ...
}: {
  flake.modules.homeManager.obsidian = {
    pkgs,
    config,
    ...
  }: {
    home.packages = with pkgs; [obsidian];
  };
}
