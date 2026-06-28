{
  self,
  lib,
  inputs,
  ...
}: {
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
    default = {};
    description = "Shared library functions exposed by the flake.";
  };

  config = {
    flake.lib.helpers = {pkgs, ...}: {
      apps = let
        getDesktopEntry = pkg: let
          drv = pkgs.runCommand "get-desktop-entry-${pkg.name}" {} ''
            for f in "${pkg}/share/applications/"*.desktop; do
              [ -f "$f" ] || continue
              if ! grep -q "^NoDisplay=true" "$f"; then
                basename "$f" > $out
                exit 0
              fi
            done
            echo "No visible .desktop file found in ${pkg.name}" >&2
            exit 1
          '';
        in
          pkgs.lib.trim (builtins.readFile drv);
        mkApp = package: {
          inherit package;
          entry = getDesktopEntry package;
        };
      in {
        terminal = mkApp pkgs.foot;
        file = mkApp pkgs.nautilus;
        doc = mkApp pkgs.papers;
        video = mkApp pkgs.vlc;
        text = {
          package = inputs.neovim-nightly.packages.${pkgs.stdenv.hostPlatform.system}.default;
          entry = "nvim-terminal-wrapper.desktop";
        };
        browser = {
          entry = "zen-beta.desktop";
        };
        archive = mkApp pkgs.file-roller;
        image = mkApp pkgs.loupe;
      };
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
