{...}: {
  flake.modules.nixos.undervolt = {...}: {
    services.undervolt = {
      enable = true;
      coreOffset = -80;
      uncoreOffset = -80;
      gpuOffset = -30;
    };
  };
}
