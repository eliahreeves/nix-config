{
  config,
  helpers,
  pkgs,
  ...
}:
helpers.mkModule config {
  name = "shell-env";
  cfg = {
    git = {
      enable = true;
      name = "Eliah Reeves";
      email = "ereeclimb@gmail.com";
    };
    tmplt.enable = true;
    direnv.enable = true;
    zsh.enable = true;
    neovim.enable = true;
    core.enable = true;
    tmux.enable = true;
    nnn.enable = true;
    programs.lazygit.enable = true;

    home.packages = with pkgs; [
      nh
    ];
  };
}
