{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "xfce-utils";
  cfg = {
    home.packages = with pkgs; [
      thunar
      tumbler
    ];
  };
}
