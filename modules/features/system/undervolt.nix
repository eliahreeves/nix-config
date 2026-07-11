{...}: {
  flake.modules.nixos.undervolt = {...}: {
    services.undervolt = {
      enable = true;
      coreOffset = -100;
      uncoreOffset = -100;
      gpuOffset = -30;
    };
  };
}
