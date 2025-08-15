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
  };
  config = lib.mkIf config.home-manager.enable {
    home-manager = {
      extraSpecialArgs = {
        inherit inputs;
        inherit tag;
        nixosConfig = config;
      };
      users = {
        "erreeves" = {
          imports = [
            homePath
            inputs.self.outputs.homeManagerModules.default
          ];
        };
      };
    };
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  };
}
