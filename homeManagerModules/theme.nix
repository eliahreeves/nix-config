{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    theme.enable = lib.mkEnableOption "Enable theme";
  };
  config = lib.mkIf config.theme.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };
    };
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita-dark";
        color-scheme = "prefer-dark";
      };
    };
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };
}
