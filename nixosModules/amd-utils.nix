{
  pkgs,
  lib,
  config,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["amdgpu"];

  hardware.graphics.extraPackages = with pkgs; [
    mesa
    amdvlk
  ];

  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  boot.kernelParams = [
    "amdgpu.si_support=1"
    "amdgpu.cik_support=1"
    "radeon.si_support=0"
    "radeon.cik_support=0"
  ];
}
