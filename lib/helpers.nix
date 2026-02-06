{lib}: rec {
  # Create a module with custom options beyond just enable
  # Usage: mkModule config { name = "git"; description = "Enable git"; options = { ... }; cfg = cfgValue: { ... }; }
  mkModule = moduleConfig: {
    name,
    description ? null,
    options ? {},
    cfg,
  }: let
    cfgValue = moduleConfig.${name};
  in {
    options = {
      ${name} =
        {
          enable = lib.mkEnableOption (
            if description != null
            then description
            else "Enable ${name}"
          );
        }
        // options;
    };
    config = lib.mkIf cfgValue.enable (
      if builtins.isFunction cfg
      then cfg cfgValue
      else cfg
    );
  };

  # Recursively import modules from all subdirectories
  # Reads all directories in the current directory and imports modules from each,
  # recursively descending into subdirectories
  autoImportCategorizedModules = dir: let
    entries = builtins.readDir dir;

    moduleFiles =
      lib.filterAttrs (
        name: type:
          type
          == "regular"
          && lib.hasSuffix ".nix" name
          && name != "default.nix"
          && name != "helpers.nix"
      )
      entries;
    modulePaths = lib.mapAttrsToList (name: _: dir + "/${name}") moduleFiles;

    categoryDirs = lib.filterAttrs (name: type: type == "directory") entries;

    subdirModules = lib.concatMap (
      name: let
        subdir = dir + "/${name}";
        subdirEntries = builtins.readDir subdir;
        hasDefaultNix = subdirEntries ? "default.nix";
      in
        # If subdirectory has default.nix, import it directly
        if hasDefaultNix
        then [subdir]
        # Otherwise recurse into it
        else (autoImportCategorizedModules subdir).imports
    ) (lib.attrNames categoryDirs);
  in {
    imports = modulePaths ++ subdirModules;
  };

  mkNixosHost = {
    name,
    nixpkgs,
    inputs,
    helpers,
  }:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs helpers;
        tag = name;
      };
      modules = [
        ../hosts/${name}/configuration.nix
        inputs.home-manager.nixosModules.default
        ../modules/nixos
      ];
    };

  mkHomeManagerHost = {
    name,
    system ? "x86_64-linux",
    nixpkgs,
    inputs,
    helpers,
    self,
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {inherit system;};
      modules = [
        ../hosts/${name}/home.nix
        self.homeManagerModules.default
      ];
      extraSpecialArgs = {
        inherit inputs helpers;
        tag = name;
      };
    };
}
