{
  helpers,
  config,
  ...
}:
helpers.mkModule config {
  name = "no-sleep";
  cfg = {
    systemd.sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
      AllowHybridSleep=no
      AllowSuspendThenHibernate=no
    '';

    networking.networkmanager.wifi.powersave = false;
  };
}
