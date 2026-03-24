{
  self,
  inputs,
  ...
}: {
  flake.homeManagerModules.python = {
    pkgs,
    config,
    ...
  }: {
    home.packages = with pkgs; [
      (python312.withPackages (p:
        with p; [
          numpy
          pandas
          matplotlib
          seaborn
        ]))
    ];
  };
}
