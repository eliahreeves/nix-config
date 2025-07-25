{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

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
  security.pam.services.greetd = {};
}
