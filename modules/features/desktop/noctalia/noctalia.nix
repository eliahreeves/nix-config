{inputs, ...}: {
  flake.modules.homeManager.noctalia = {
    config,
    lib,
    ...
  }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];
    options.noctalia.configPath = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/nix-config/modules/features/desktop/noctalia/config";
      description = "Path to noctalia configuration directory";
    };
    config = {
      programs.noctalia = {
        enable = true;
        systemd.enable = true;
      };

      home.file = {
        ".config/noctalia".source =
          config.lib.file.mkOutOfStoreSymlink config.noctalia.configPath;
      };
    };
  };
}
