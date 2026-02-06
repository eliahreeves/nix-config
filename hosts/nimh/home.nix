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
    wl-clipboard
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  programs = {
    home-manager.enable = true;
    lazygit.enable = true;
  };

  zsh = {
    enable = true;
    autolaunchTmux = true;
    simplify = true;
  };
  git = {
    sign = false;
    enable = true;
    name = "Eliah Reeves";
    email = "ereeclimb@gmail.com";
  };
  core.enable = true;
  tmux.enable = true;
  tmux.prefix = "b";
  firefox.enable = true;
}
