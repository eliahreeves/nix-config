{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.adwaita-qt = {pkgs, ...}: {
    qt = {
      enable = true;
      style = "adwaita-dark";
    };
  };
}
