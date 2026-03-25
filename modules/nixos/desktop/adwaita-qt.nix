{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.adwaita-qt = {pkgs, ...}: {
    qt = {
      enable = true;
      style = "adwaita-dark";
    };
  };
}
