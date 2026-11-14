{self, ...}: {
  flake.modules.nixos.gnome = {pkgs, ...}: {
    home-manager.sharedModules = [self.modules.homeManager.qt-gtk-theme];
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    environment.systemPackages = with pkgs; [
      gnomeExtensions.blur-my-shell
    ];
  };
}
