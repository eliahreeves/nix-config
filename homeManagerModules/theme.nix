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
    home.sessionVariables = {
      GTK_THEME = "Adwaita-dark";
      COLOR_SCHEME = "prefer-dark";
    };
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
      # x11.enable = true;
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
  };
}
