{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    ollama.enable = lib.mkEnableOption "Enable ollama";
  };
  config = lib.mkIf config.ollama.enable {
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
