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
      userName = "Eliah Reeves";
      userEmail = "ereeclimb@gmail.com";
      signing = {
        signByDefault = config.git.sign;
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        pull = {
          rebase = false;
        };
      };
    };
  };
}
