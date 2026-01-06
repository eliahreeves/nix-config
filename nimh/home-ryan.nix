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
    immich-go
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

  zsh.autolaunchTmux = false;
  zsh.simplify = true;
  git.sign = false;
  tmux.enable = false;
}
