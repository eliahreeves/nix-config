{
  inputs,
  config,
  ...
}: {
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      nixosConfig = config;
    };
    users = {
      "erreeves" = {
        imports = [
          ../computer/home.nix
          inputs.self.outputs.homeManagerModules.default
        ];
      };
    };
  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
}
