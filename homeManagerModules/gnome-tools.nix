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
    # home.file = {
    #   ".config/gtk-3.0/bookmarks".text = ''
    #     file://${homeDir}/Documents Documents
    #     file://${homeDir}/Pictures Pictures
    #     file://${homeDir}/Programs Programs
    #     file://${homeDir}/repos Repos
    #     file://${homeDir}/Downloads Downloads
    #   '';
    # };
  };
}
