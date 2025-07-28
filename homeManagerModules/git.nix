{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    git.enable = lib.mkEnableOption "Enable git";
  };
  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = "Eliah Reeves";
      userEmail = "ereeclimb@gmail.com";
      signing = {
        signByDefault = true;
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
