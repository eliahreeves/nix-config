{
  self,
  inputs,
  ...
}: {
  flake.homeManagerModules.obsidian = {
    pkgs,
    config,
    ...
  }: {
    home.packages = with pkgs; [obsidian];
  };
}
