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
        user = lib.mkOption {
          type = lib.types.str;
          description = "user persist";
        };
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "enable preservation";
        };
        directories = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
        };
        files = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
        };
        userDirectories = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
        };
        userFiles = lib.mkOption {
          type = lib.types.listOf lib.types.str;
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
            users.${config.persist.user} = {
              directories =
                config.persist.userDirectories
                ++ [
                  ".ssh"
                  ".gnupg"
                  "nix-config"
                ];
              files =
                config.persist.userFiles;
            };
          };
        };
        systemd.suppressedSystemUnits = ["systemd-machine-id-commit.service"];
      };
    };
  };
}
