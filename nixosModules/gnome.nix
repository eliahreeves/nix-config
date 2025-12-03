{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    gnome.enable = lib.mkEnableOption "Enable gnome";
  };
  config = lib.mkIf config.gnome.enable {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
  };
}
