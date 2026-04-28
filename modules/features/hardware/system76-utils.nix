{...}: {
  flake.modules.nixos.system76-utils = {...}: {
    hardware.system76.enableAll = true;
  };
}
