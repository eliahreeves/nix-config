{self, ...}: {
  flake.modules.nixos.git = {
    home-manager.sharedModules = [self.modules.homeManager.git];
  };
  flake.modules.homeManager.git = {
    lib,
    config,
    ...
  }: {
    options.git = {
      sign = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "sign commit";
      };
      name = lib.mkOption {
        type = lib.types.str;
        description = "name";
        default = "Eliah Reeves";
      };
      email = lib.mkOption {
        type = lib.types.str;
        description = "email";
        default = "ereeclimb@gmail.com";
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
