{self, ...}: {
  flake.modules.nixos.cursor-cli = {
    home-manager.sharedModules = [self.modules.homeManager.cursor-cli];
  };
  flake.modules.homeManager.cursor-cli = {pkgs, ...}: {
    home.packages = with pkgs; [
      cursor-cli
    ];
    programs.git = {ignores = [".cursor/"];};
  };
}
