{self, ...}: {
  flake.modules.nixos.vscode = {
    home-manager.sharedModules = [self.modules.homeManager.vscode];
  };
  flake.modules.homeManager.vscode = {pkgs, ...}: {
    programs.vscodium = {
      enable = true;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          dart-code.flutter
          dart-code.dart-code
        ];
        userSettings = {
          "security.workspace.trust.enabled" = false;
          "explorer.confirmDelete" = false;
          "files.autoSave" = "afterDelay";
          "explorer.confirmDragAndDrop" = false;
        };
      };
    };
  };
}
