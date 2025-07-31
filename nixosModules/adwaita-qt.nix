{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    adwaita-qt.enable = lib.mkEnableOption "adwaita-qt theme";
  };
  config = lib.mkIf config.adwaita-qt.enable {
    qt = {
      enable = true;
      style = "adwaita-dark";
    };
  };
}
