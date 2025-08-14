{
  config,
  pkgs,
  lib,
  nixosConfig ? null,
  ...
}: {
  home.username = "erreeves";
  home.homeDirectory = "/home/erreeves";
  home.stateVersion = "25.05"; # Please read the comment before changing.
  home.packages = with pkgs; [
    nodejs_24
  ];

  tmux.enable = true;
  git.sign = false;

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  programs = {
    home-manager.enable = true;
  };
}
