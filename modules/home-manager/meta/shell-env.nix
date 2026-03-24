{
  self,
  inputs,
  ...
}: {
  flake.homeManagerModules.shell-env = {
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = with self.homeManagerModules; [
      core
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
