{
  inputs,
  lib,
  config,
  homePath,
  tag,
  ...
}: {
  options = {
    home-manager.enable = lib.mkEnableOption "Enable home-manager";
    home-manager.extraUsers = lib.mkOption {
      type = lib.types.attrsOf lib.types.path;
      default = {};
      example = {"alice" = ./home-alice.nix;};
      description = ''
        Additional Home Manager users to configure on this host.
        Provide a set mapping usernames to their home.nix module path.
      '';
    };
  };
  config = lib.mkIf config.home-manager.enable {
    home-manager = {
      extraSpecialArgs = {
        inherit inputs;
        inherit tag;
        nixosConfig = config;
      };
      users =
        {
          "erreeves" = {
            imports = [
              homePath
              inputs.self.outputs.homeManagerModules.default
            ];
          };
        }
        // lib.mapAttrs (user: path: {
          imports = [
            path
            inputs.self.outputs.homeManagerModules.default
          ];
        })
        config.home-manager.extraUsers;
    };
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  };
}
