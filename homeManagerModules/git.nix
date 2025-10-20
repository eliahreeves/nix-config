{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    git.enable = lib.mkEnableOption "Enable git";
    git.sign = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "sign commit";
    };
  };
  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Eliah Reeves";
          email = "ereeclimb@gmail.com";
        };
        init = {
          defaultBranch = "main";
        };
        pull = {
          rebase = false;
        };
      };
      signing = {
        signByDefault = config.git.sign;
      };
    };
  };
}
