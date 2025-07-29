{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    amd-utils.enable = lib.mkEnableOption "Enable amd graphics utils";
  };
  config = lib.mkIf config.amd-utils.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver.videoDrivers = ["amdgpu"];

    hardware.graphics.extraPackages = with pkgs; [
      mesa
    ];
  };
}
