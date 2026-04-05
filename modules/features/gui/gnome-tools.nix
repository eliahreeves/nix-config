{self, ...}: {
  flake.modules.nixos.gnome-tools = {
    home-manager.sharedModules = [self.modules.homeManager.gnome-tools];
  };
  flake.modules.homeManager.gnome-tools = {pkgs, ...}: {
    home.packages = with pkgs; [
      loupe
      papers
      gnome-disk-utility
      snapshot
      warp
      nautilus
      gnome-software
      networkmanagerapplet
      gnome-text-editor
    ];
    xdg.configFile."autostart/nm-applet.desktop".text = ''
      [Desktop Entry]
      Hidden=true
    '';
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["org.gnome.Nautilus.desktop"];
        "application/pdf" = ["org.gnome.Papers.desktop"];

        "image/png" = ["org.gnome.Loupe.desktop"];
        "image/jpeg" = ["org.gnome.Loupe.desktop"];
        "image/bmp" = ["org.gnome.Loupe.desktop"];
        "image/gif" = ["org.gnome.Loupe.desktop"];
        "image/tiff" = ["org.gnome.Loupe.desktop"];
        "image/webp" = ["org.gnome.Loupe.desktop"];
        "image/svg+xml" = ["org.gnome.Loupe.desktop"];
        "image/x-tga" = ["org.gnome.Loupe.desktop"];
      };
    };
  };
}
