{self, ...}: {
  flake.modules.nixos.hm-dir = let
    folders = [
      "Projects"
      "Documents"
      "Downloads"
      "Pictures"
      "Videos"
      "Audiobooks"
      "Music"
    ];
  in {
    home-manager.sharedModules = [self.modules.homeManager.hm-dir {_module.args = {inherit folders;};}];
    persist.userDirectories = folders ++ [".secrets"];
  };
  flake.modules.homeManager.hm-dir = {
    folders,
    config,
    ...
  }: {
    gtk.gtk3.bookmarks = let
      homePath = "file://${config.home.homeDirectory}/";
    in
      map (folder: "${homePath}${folder}") folders;
  };
}
