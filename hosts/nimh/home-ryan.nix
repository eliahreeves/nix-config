{
  config,
  pkgs,
  lib,
  ...
}: {
  home.username = "rlreeves";
  home.stateVersion = "25.05"; # Please read the comment before changing.
  home.packages = with pkgs; [
    wl-clipboard
    immich-go
    signal-desktop
    gnome-text-editor
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

  zsh = {
    autolaunchTmux = false;
    enable = true;
    simplify = true;
  };

  git = {
    sign = false;
    enable = true;
  };

  core.enable = true;
  direnv.enable = true;
}
