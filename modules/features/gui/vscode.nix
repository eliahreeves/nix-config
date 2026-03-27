{self, ...}: {
  flake.modules.nixos.vscode = {
    home-manager.sharedModules = [self.modules.homeManager.vscode];
  };
  flake.modules.homeManager.vscode = {pkgs, ...}: {
    programs.vscode = {
      enable = true;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
        ];
      };
    };
  };
}
