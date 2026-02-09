{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "thunar";
  cfg = {
    home.packages = with pkgs; [
      thunar
      tumbler
    ];
  };
}
