{
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "direnv";
  cfg = {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
