{self, ...}: {
  flake.modules.nixos.python = {
    home-manager.sharedModules = [self.modules.homeManager.python];
  };
  flake.modules.homeManager.python = {pkgs, ...}: {
    home.packages = with pkgs; [
      (python312.withPackages (p:
        with p; [
          numpy
          pandas
          matplotlib
          seaborn
        ]))
    ];
  };
}
