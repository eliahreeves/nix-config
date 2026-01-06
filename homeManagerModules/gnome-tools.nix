{
  pkgs,
  lib,
  config,
  ...
}: let
  homeDir = "/home/${config.home.username}";
in {
  options = {
    gnome-tools.enable = lib.mkEnableOption "Enable gnome-tools";
  };
  config = lib.mkIf config.gnome-tools.enable {
    home.packages = with pkgs; [
      seahorse
      loupe
      gnome-disk-utility
      papers
    ];
  };
}
