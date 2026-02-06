{
  description = "Nix config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    eko-messenger = {
      url = "github:eko-network/eko-messenger";
    };

    eko-messenger-client = {
      url = "github:eko-network/eko-messenger-client";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    helpers = import ./lib/helpers.nix {inherit (nixpkgs) lib;};
  in {
    homeManagerModules = {
      default = import ./modules/home-manager {
        inherit helpers;
        lib = nixpkgs.lib;
      };
    };

    nixosConfigurations = {
      computer = helpers.mkNixosHost {
        name = "computer";
        inherit nixpkgs inputs helpers;
      };
      nimh = helpers.mkNixosHost {
        name = "nimh";
        inherit nixpkgs inputs helpers;
      };
    };
    homeConfigurations = {
      wsl = helpers.mkHomeManagerHost {
        name = "wsl";
        inherit nixpkgs inputs helpers self;
      };
    };
  };
}
