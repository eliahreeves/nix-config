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
      QT_STYLE_OVERRIDE = "adwaita-dark";
    };
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
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
      x11.enable = true;
      name = "Adwaita";
      size = 24;
      package = pkgs.adwaita-icon-theme;
    };
    home.packages = with pkgs; [
      adwaita-qt
    ];
  };
}
