{self, ...}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    home-manager.sharedModules = [self.modules.homeManager.niri];
    imports = [self.modules.nixos.greetd];
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
    ...
  }: {
    imports = with self.modules.homeManager; [noctalia vlc];

    home.packages = with pkgs; [
      python313Packages.ipython
      bluetuith
    ];

    home.file = {
      ".config/niri".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/niri";
    };
  };
}
