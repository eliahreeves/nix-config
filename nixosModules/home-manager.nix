{inputs, ... }:{
      home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "erreeves" = {imports = [ ../computer/home.nix
      inputs.self.outputs.homeManagerModules.default
      ];};
    };

  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
}