{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.system76-utils = {pkgs, ...}: {
    hardware.system76 = {
      firmware-daemon.enable = true;
      kernel-modules.enable = true;
    };
  };
}
