{self, ...}: {
  flake.modules.nixos.lazygit = {
    home-manager.sharedModules = [self.modules.homeManager.lazygit];
  };
  flake.modules.homeManager.lazygit = {
    pkgs,
    lib,
    ...
  }: {
    programs.lazygit = {
      enable = true;
      settings = {
        git = {
          ignoreWhitespaceInDiffView = true;
          pagers = [
            {pager = "${lib.getExe pkgs.delta} --dark --paging=never --side-by-side --line-numbers-left-format='' --line-numbers-right-format='' --hunk-header-style syntax";}
            {pager = "${lib.getExe pkgs.delta} --dark --paging=never --hunk-header-style syntax";}
          ];
        };
        gui = {
          sidePanelWidth = 0.2;
          expandFocusedSidePanel = true;
        };
      };
    };
  };
}
