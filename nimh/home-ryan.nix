{
  config,
  pkgs,
  lib,
  nixosConfig ? null,
  ...
}: {
  home.username = "rlreeves";
  home.stateVersion = "25.05"; # Please read the comment before changing.
  home.packages = with pkgs; [
    wl-clipboard
    google-chrome
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  programs = {
    home-manager.enable = true;
    lazygit.enable = true;
  };

  firefox.enable = true;

  zsh.autolaunchTmux = true;
  zsh.simplify = true;
  git.sign = false;
  tmux.enable = true;
  tmux.prefix = "b";
  plasma.enable = false;
}
