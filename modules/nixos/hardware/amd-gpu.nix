{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "amd-gpu";
  cfg = {
    environment.systemPackages = with pkgs; [
      rocmPackages.rocm-smi
    ];
  };
}
