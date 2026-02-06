{
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "steam";
  cfg = {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
