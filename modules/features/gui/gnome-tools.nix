{self, ...}: {
  flake.modules.nixos.gnome-tools = {
    home-manager.sharedModules = [self.modules.homeManager.gnome-tools];
  };
  flake.modules.homeManager.gnome-tools = {pkgs, ...}: {
    home.packages = with pkgs; [
      gnome-disk-utility
      snapshot
      warp
      gnome-software
      networkmanagerapplet
    ];
    xdg.configFile."autostart/nm-applet.desktop".text = ''
      [Desktop Entry]
      Hidden=true
    '';
  };
}
