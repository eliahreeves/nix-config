{
  inputs,
  config,
  tag,
  lib,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "home-manager-config";
  options = {
    users = lib.mkOption {
      type = lib.types.attrsOf lib.types.path;
      default = {};
      example = {
        alice = ./home/alice.nix;
        bob = ./home/bob.nix;
      };
      description = "A map of usernames to their Home Manager configuration files.";
    };
  };
  cfg = cfgValue: {
    home-manager = {
      extraSpecialArgs = {
        inherit inputs helpers;
        inherit tag;
        nixosConfig = config;
      };
      users =
        lib.mapAttrs (username: path: {
          imports = [
            path
            inputs.self.outputs.homeManagerModules.default
          ];
        })
        cfgValue.users;
    };
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  };
}
