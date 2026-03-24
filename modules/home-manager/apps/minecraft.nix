{
  self,
  inputs,
  ...
}: {
  flake.homeManagerModules.minecraft = {
    pkgs,
    lib,
    config,
    ...
  }: {
    home.packages = with pkgs; [prismlauncher];
  };
}
