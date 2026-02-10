{
  config,
  pkgs,
  lib,
  ...
}: {
  home.username = "erreeves";
  home.stateVersion = "25.05"; # Please read the comment before changing.
  home.packages = with pkgs; [
    immich-go
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  programs = {
    home-manager.enable = true;
  };

  zsh = {
    simplify = true;
  };
  git = {
    sign = false;
  };
  tmux.prefix = "b";
  shell-env.enable = true;
  firefox.enable = true;
}
