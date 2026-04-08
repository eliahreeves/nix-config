{inputs, ...}: {
  flake.modules.nixos.comma = {...}: {
    imports = [
      inputs.nix-index-database.nixosModules.default
      {programs.nix-index-database.comma.enable = true;}
    ];
  };
}
