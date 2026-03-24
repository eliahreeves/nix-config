{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.gnome = {
    pkgs,
    lib,
    config,
    ...
  }: {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
  };
}
