{
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "printing";
  cfg = {
    services.printing.enable = true;

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
