{
  self,
  inputs,
  ...
}: {
  flake.homeManagerModules.latex = {
    pkgs,
    config,
    ...
  }: {
    home.packages = with pkgs; [
      texliveFull
    ];
  };
}
