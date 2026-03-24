{
  self,
  inputs,
  ...
}: {
  flake.homeManagerModules.thunar = {
    pkgs,
    config,
    ...
  }: {
    home.packages = with pkgs; [
      thunar
      tumbler
    ];
  };
}
