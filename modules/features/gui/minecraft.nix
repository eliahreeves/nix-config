{
  self,
  inputs,
  ...
}: {
  flake.modules.homeManager.minecraft = {
    pkgs,
    lib,
    config,
    ...
  }: {
    home.packages = with pkgs; [prismlauncher];
  };
}
