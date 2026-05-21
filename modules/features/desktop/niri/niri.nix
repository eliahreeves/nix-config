{self, ...}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    home-manager.sharedModules = [self.modules.homeManager.niri];
    imports = [
      self.modules.nixos.greetd
    ];
    programs.niri = {
      enable = true;
    };
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.systemPackages = with pkgs; [
      xwayland-satellite
      playerctl
      brightnessctl
    ];
  };

  flake.modules.homeManager.niri = {
    pkgs,
    config,
    lib,
    helpers,
    ...
  }: let
    base = pkgs.replaceVars ./config/base.kdl {
      terminal = lib.getExe helpers.apps.terminal.package;
      browser = lib.getExe helpers.apps.browser.package;
      explorer = lib.getExe helpers.apps.file.package;
    };
  in {
    imports = with self.modules.homeManager; [noctalia];
    options.niri.configPath = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/nix-config/modules/features/desktop/niri/config/config.kdl";
      description = "Path to niri configuration file";
    };
    config = {
      home.packages = with pkgs; [
        bluetuith
      ];

      home.file = {
        ".config/niri/config.kdl".source =
          config.lib.file.mkOutOfStoreSymlink config.niri.configPath;
        ".config/niri/base.kdl".source = base;
      };
    };
  };
}
