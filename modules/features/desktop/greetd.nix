{...}: {
  flake.modules.nixos.greetd = {
    pkgs,
    lib,
    ...
  }: {
    security.pam.services.greetd.enableGnomeKeyring = true;
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = ''
            ${lib.getExe pkgs.tuigreet} -r
          '';
          user = "greeter";
        };
      };
    };
  };
}
