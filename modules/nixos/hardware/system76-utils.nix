{
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "system76-utils";
  cfg = {
    hardware.system76.enableAll = true;
  };
}
