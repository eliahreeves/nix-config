{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "distrobox";
  cfg = {
    virtualisation = {
      containers.enable = true;
      docker = {
        enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      dive
      distrobox
    ];
  };
}
