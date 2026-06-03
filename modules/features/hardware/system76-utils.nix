{...}: {
  flake.modules.nixos.system76-utils = {...}: {
    hardware.system76 = {
      kernel-modules.enable = true;
      firmware-daemon.enable = true;
    };
  };
}
