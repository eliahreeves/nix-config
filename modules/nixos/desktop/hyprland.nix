{
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "hyprland";
  cfg = {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    services.gnome.gnome-keyring.enable = true;
  };
}
