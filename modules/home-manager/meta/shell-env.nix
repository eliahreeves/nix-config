{
  config,
  helpers,
  pkgs,
  lib,
  ...
}:
helpers.mkModule config {
  name = "shell-env";
  cfg = {
    git = {
      enable = lib.mkDefault true;
      name = lib.mkDefault "Eliah Reeves";
      email = lib.mkDefault "ereeclimb@gmail.com";
    };
    tmplt.enable = lib.mkDefault true;
    direnv.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    neovim.enable = lib.mkDefault true;
    core.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    nnn.enable = lib.mkDefault true;
    programs.lazygit.enable = lib.mkDefault true;

    home.packages = with pkgs; [
      nh
    ];
  };
}
