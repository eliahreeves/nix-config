{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # eko-messenger = {
    #   url = "path:/home/erreeves/repos/eko-messenger";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations = {
      computer = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          homePath = ./computer/home.nix;
          tag = "computer";
        };
        modules = [
          ./computer/configuration.nix
          inputs.home-manager.nixosModules.default
          ./nixosModules
        ];
      };
      nimh = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          homePath = ./nimh/home.nix;
          tag = "nimh";
        };
        modules = [
          ./nimh/configuration.nix
          inputs.home-manager.nixosModules.default
          ./nixosModules
        ];
      };
    };
    homeManagerModules.default = import ./homeManagerModules;
    homeConfigurations = {
      wsl = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        modules = [
          ./wsl/home.nix
          self.homeManagerModules.default
        ];
        extraSpecialArgs = {
          inherit inputs;
          tag = "wsl";
        };
      };
    };
  };
}
