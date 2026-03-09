{
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "system76-utils";
  cfg = {
    hardware.system76 = {
      firmware-daemon.enable = true;
      kernel-modules.enable = true;
    };
  };
}
