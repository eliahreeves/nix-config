{
  self,
  lib,
  ...
}: {
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
    default = {};
    description = "Shared library functions exposed by the flake.";
  };

  config = {
    flake.lib.helpers = {pkgs, ...}: {
      getDesktopEntry = pkg: let
        drv = pkgs.runCommand "get-desktop-entry-${pkg.name}" {} ''
          files=("${pkg}/share/applications/"*.desktop)
          if [ ''${#files[@]} -eq 0 ]; then
            echo "No .desktop files found in ${pkg.name}" >&2
            exit 1
          else
            basename "''${files[0]}" > $out
          fi
        '';
      in
        lib.trim (builtins.readFile drv);
    };

    flake.modules.nixos.helpers = {pkgs, ...}: {
      _module.args.helpers = self.lib.helpers {inherit pkgs;};
      home-manager.sharedModules = [self.modules.homeManager.helpers];
    };

    flake.modules.homeManager.helpers = {pkgs, ...}: {
      _module.args.helpers = self.lib.helpers {inherit pkgs;};
    };
  };
}
