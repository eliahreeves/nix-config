{
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "capslock-arrow-keys";
  cfg = {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings = {
          main = {
            capslock = "overload(capslock, esc)";
          };

          capslock = {
            h = "left";
            j = "down";
            k = "up";
            l = "right";
          };
        };
      };
    };
  };
}
