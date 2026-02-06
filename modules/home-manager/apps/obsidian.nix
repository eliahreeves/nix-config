{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "obsidian";
  cfg = {
    home.packages = with pkgs; [obsidian];
  };
}
