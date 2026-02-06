{
  pkgs,
  lib,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "ollama";
  cfg = {
    environment.systemPackages = with pkgs; [
      rocmPackages.rocminfo
      rocmPackages.rocm-smi
      rocmPackages.rocblas
      rocmPackages.hipcc
      rocmPackages.rocm-runtime
    ];

    services.ollama = {
      enable = true;
      acceleration = "rocm";
    };
    systemd.services.ollama.wantedBy = lib.mkForce [];
  };
}
