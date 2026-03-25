{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.home-manager-config = {
    config,
    lib,
    ...
  }: {
    options.home-manager-config = {
      enable = lib.mkEnableOption "home-manager-config";
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

    config = lib.mkIf config.home-manager-config.enable {
      home-manager = {
        extraSpecialArgs = {
          inherit inputs;
          nixosConfig = config;
        };
        users =
          lib.mapAttrs (username: path: {
            imports = [
              path
              self.modules.homeManager.default
            ];
          })
          config.home-manager-config.users;
      };
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    };
  };
}
