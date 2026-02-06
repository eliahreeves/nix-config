{
  pkgs,
  lib,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "git";
  options = {
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
  cfg = cfgValue: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = cfgValue.name;
          email = cfgValue.email;
        };
        init = {
          defaultBranch = "main";
        };
        pull = {
          rebase = true;
        };
      };
      signing = {
        signByDefault = cfgValue.sign;
      };
    };
  };
}
