{
  config,
  pkgs,
  lib,
  ...
}: {
  home.username = "ctknab";
  home.stateVersion = "25.05"; # Please read the comment before changing.
  home.packages = with pkgs; [
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
  git.email = "";
  git.name = "";
  # my neovim. requires my dotfiles in your home
  neovim.enable = false;
}
