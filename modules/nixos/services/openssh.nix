{
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "openssh";
  cfg = {
    services.fail2ban.enable = true;
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
