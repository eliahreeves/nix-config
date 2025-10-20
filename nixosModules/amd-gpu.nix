{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    amd-gpu.enable = lib.mkEnableOption "Enable amd-gpufor running unpatched dynamic binaries";
  };
  config = lib.mkIf config.amd-gpu.enable {
    environment.systemPackages = with pkgs; [
      rocmPackages.rocm-smi
    ];
  };
}
