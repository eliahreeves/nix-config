{inputs, ...}: {
  flake.modules.nixos.artcraft = {...}: {
    imports = [inputs.nix-craftapps.nixosModules.default];
    programs.craftapps = {
      enable = true;
      apps.filmcraft.enable = true;
    };
  };
}
