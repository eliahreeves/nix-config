{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    gnome-tools.enable = lib.mkEnableOption "Enable gnome-tools";
  };
  config = lib.mkIf config.gnome-tools.enable {
    home.packages = with pkgs; [
      nautilus
      seahorse
      loupe
      gnome-disk-utility
      papers
      # added to make nautilus detect removable media. May not be required
      gvfs
    ];
    home.file = {
      ".config/gtk-3.0/bookmarks".text = ''
        file:///home/erreeves/Documents Documents
        file:///home/erreeves/Pictures Pictures
        file:///home/erreeves/Programs Programs
        file:///home/erreeves/repos Repos
        file:///home/erreeves/Downloads Downloads
      '';
    };
  };
}
