{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.greetd = {pkgs, ...}: {
    security.pam.services.greetd.enableGnomeKeyring = true;
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = ''
            ${pkgs.tuigreet}/bin/tuigreet -r
          '';
          user = "greeter";
        };
      };
    };
  };
}
