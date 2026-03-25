{
  self,
  inputs,
  ...
}: {
  flake.modules.homeManager.thunar = {
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
