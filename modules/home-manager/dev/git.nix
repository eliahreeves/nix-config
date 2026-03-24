{...}: {
  flake.homeManagerModules.git = {
    lib,
    config,
    ...
  }: {
    options.git = {
      sign = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "sign commit";
      };
      name = lib.mkOption {
        type = lib.types.str;
        description = "name";
      };
      email = lib.mkOption {
        type = lib.types.str;
        description = "email";
      };
    };

    config = {
      programs.git = {
        enable = true;
        settings = {
          safe.directory = "/etc/nixos";
          user = {
            name = config.git.name;
            email = config.git.email;
          };
          init = {
            defaultBranch = "main";
          };
          pull = {
            rebase = true;
          };
        };
        signing = {
          signByDefault = config.git.sign;
        };
      };
    };
  };
}
