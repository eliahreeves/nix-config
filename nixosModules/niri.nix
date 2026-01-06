{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {niri.enable = lib.mkEnableOption "Enable niri";};
  config = lib.mkIf config.niri.enable {
    programs.niri = {
      enable = true;
    };
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
  };
}
