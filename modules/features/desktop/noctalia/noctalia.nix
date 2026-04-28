{
  self,
  inputs,
  ...
}: {
  flake.modules.homeManager.noctalia = {
    pkgs,
    config,
    lib,
    ...
  }: {
    imports = [
      inputs.noctalia.homeModules.default
      self.modules.homeManager.hypridle
    ];
    options.noctalia.configPath = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/nix-config/modules/features/desktop/noctalia/config";
      description = "Path to noctalia configuration directory";
    };
    config = {
      programs.noctalia-shell = {
        enable = true;
        package = pkgs.noctalia-shell.override {calendarSupport = true;};
      };

      home.file = {
        ".config/noctalia".source =
          config.lib.file.mkOutOfStoreSymlink config.noctalia.configPath;
      };
    };
  };
}
