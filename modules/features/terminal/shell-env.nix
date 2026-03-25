{self, ...}: {
  flake.modules.homeManager.shell-env = {
    pkgs,
    lib,
    ...
  }: {
    imports = with self.modules.homeManager; [
      user-core
      git
      tmplt
      direnv
      zsh
      tmux
      nnn
    ];

    git = {
      name = lib.mkDefault "Eliah Reeves";
      email = lib.mkDefault "ereeclimb@gmail.com";
    };

    programs.lazygit.enable = lib.mkDefault true;

    home.packages = with pkgs; [
      nh
    ];
  };
}
