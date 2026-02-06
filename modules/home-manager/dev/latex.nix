{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "latex";
  cfg = {
    home.packages = with pkgs; [
      texliveFull
    ];
  };
}
