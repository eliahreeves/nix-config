{...}: {
  flake.modules.nixos.greetd = {
    pkgs,
    lib,
    ...
  }: {
    persist.files = ["/var/cache/tuigreet/lastuser"];
    persist.userDirectories = [".local/share/keyrings"];
    security.pam.services.greetd.enableGnomeKeyring = true;
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.tuigreet} -r";
          user = "greeter";
        };
      };
    };
  };
}
