{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {greetd.enable = lib.mkEnableOption "Enable greetd";};
  config = lib.mkIf config.greetd.enable {
    security.pam.services.greetd.enableGnomeKeyring = true;
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = ''
            ${pkgs.tuigreet}/bin/tuigreet \
            -r \
            --cmd hyprland
          '';
          user = "greeter";
        };
      };
    };
  };
}
