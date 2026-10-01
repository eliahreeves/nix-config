{inputs, ...}: {
  config = {
    flake.modules.nixos.persist = {
      config,
      lib,
      ...
    }: {
      imports = [
        inputs.preservation.nixosModules.default
      ];
      options.persist = {
        path = lib.mkOption {
          type = lib.types.str;
          default = "/persistent";
          description = "directory to persist in";
        };
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "enable preservation";
        };
        directories = lib.mkOption {
          type = with lib.types; listOf (either str attrs);
          default = [];
        };
        files = lib.mkOption {
          type = with lib.types; listOf (either str attrs);
          default = [];
        };
      };
      config = lib.mkIf config.persist.enable {
        preservation = {
          enable = true;
          preserveAt.${config.persist.path} = {
            directories =
              config.persist.directories
              ++ [
                {
                  directory = "/var/lib/nixos";
                  inInitrd = true;
                }
              ];
            files =
              config.persist.files
              ++ [
                {
                  file = "/etc/machine-id";
                  inInitrd = true;
                }
              ];
          };
        };
        systemd.suppressedSystemUnits = ["systemd-machine-id-commit.service"];
      };
    };
  };
}
