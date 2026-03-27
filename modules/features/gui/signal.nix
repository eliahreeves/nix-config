{self, ...}: {
  flake.modules.nixos.signal = {
    home-manager.sharedModules = [self.modules.homeManager.signal];
  };
  flake.modules.homeManager.signal = {pkgs, ...}: {
    home.packages = with pkgs; [signal-desktop];
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/sgnl" = ["signal.desktop"];
        "x-scheme-handler/signalcaptcha" = ["signal.desktop"];
      };
    };
  };
}
