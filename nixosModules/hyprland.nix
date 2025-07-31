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

    services.greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          command = ''
            ${pkgs.greetd.tuigreet}/bin/tuigreet \
            -r \
            --cmd hyprland
          '';
          user = "greeter";
        };
      };
    };

    # These might not be needed. added to make nautilus detect disks.
    security.pam.services.greetd = {};
    programs.dconf.enable = true;
    services.gnome.gnome-keyring.enable = true;
  };
}
