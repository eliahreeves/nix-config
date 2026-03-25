{
  self,
  inputs,
  ...
}: {
  flake.modules.homeManager.latex = {
    pkgs,
    config,
    ...
  }: {
    home.packages = with pkgs; [
      texliveFull
    ];
  };
}
