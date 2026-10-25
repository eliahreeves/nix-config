{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    home-manager.sharedModules = [self.modules.homeManager.niri];
    imports = with self.modules.nixos; [
      greetd
      noctalia
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
    ...
  }: let
    browser = lib.getExe inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default;
    # if config.programs.zen-browser.enable or false
    # then lib.getExe config.programs.zen-browser.finalPackage
    # else "zen-beta";
    base = pkgs.replaceVars ./config/base.kdl {
      terminal = lib.getExe config.defaultApps.terminal.package;
      inherit browser;
      explorer = lib.getExe config.defaultApps.file.package;
    };
  in {
    options.niri.configPath = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/nix-config/modules/features/desktop/niri/config/config.kdl";
      description = "Path to niri configuration file";
    };
    options.niri.hostConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Host-specific niri config, written to host.kdl.";
    };
    config = {
      home.packages = with pkgs; [
        bluetuith
      ];

      home.file = {
        ".config/niri/config.kdl".source =
          config.lib.file.mkOutOfStoreSymlink config.niri.configPath;
        ".config/niri/base.kdl".source = base;
        ".config/niri/host.kdl".text = config.niri.hostConfig;
      };
    };
  };
}
