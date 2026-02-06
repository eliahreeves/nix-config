{
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "power-button-sleep";
  cfg = {
    services.logind.settings.Login.HandlePowerKey = "suspend";
  };
}
