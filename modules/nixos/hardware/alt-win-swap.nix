{
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "alt-win-swap";
  cfg = {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings = {
          main = {
            leftalt = "leftmeta";
            rightalt = "leftmeta";
            leftmeta = "leftalt";
          };
        };
      };
    };
  };
}
