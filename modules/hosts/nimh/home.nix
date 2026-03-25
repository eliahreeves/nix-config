{self, ...}: {
  flake.modules.homeManager.nimh-home = {...}: {
    imports = with self.modules.homeManager; [
      shell-env
    ];

    home.stateVersion = "25.05";
    programs = {
      home-manager.enable = true;
    };
  };

  flake.modules.homeManager.nimh-home-erreeves = {...}: {
    imports = with self.modules.homeManager; [
      nimh-home
    ];
    home.username = "erreeves";
    home.homeDirectory = "/home/erreeves";
  };
}
