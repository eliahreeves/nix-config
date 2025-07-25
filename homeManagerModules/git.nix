{pkgs, lib, config, ...}:{

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
}