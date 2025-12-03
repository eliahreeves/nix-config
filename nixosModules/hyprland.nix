{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {hyprland.enable = lib.mkEnableOption "Enable hyprland";};
  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # These might not be needed. added to make nautilus detect disks.
    programs.dconf.enable = true;
    services.gnome.gnome-keyring.enable = true;
  };
}
