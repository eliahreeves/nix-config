{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "docker";
  cfg = {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
    };
    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
