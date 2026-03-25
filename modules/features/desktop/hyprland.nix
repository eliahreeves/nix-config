{self, ...}: {
  flake.modules.nixos.hyprland = {...}: {
    imports = [self.modules.nixos.greetd];
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    services.gnome.gnome-keyring.enable = true;
  };

  flake.modules.homeManager.hyprland-utils = {
    pkgs,
    config,
    ...
  }: let
    homeDir = config.home.homeDirectory;
  in {
    home.packages = with pkgs; [
      swaynotificationcenter
      swayosd
      waybar
      rofi
      python313Packages.ipython
      brightnessctl
      hyprpaper
      hyprpicker
      hyprpolkitagent
      networkmanagerapplet
      hyprsunset
      hypridle
      bluetuith
      vlc
      hyprlock
      slurp
      grim
      wlogout
      libnotify
    ];
    home.file = {
      ".config/swaync".source =
        config.lib.file.mkOutOfStoreSymlink "${homeDir}/.dotfiles/swaync";
      ".config/hypr".source =
        config.lib.file.mkOutOfStoreSymlink "${homeDir}/.dotfiles/hyprland";
      ".config/wlogout".source =
        config.lib.file.mkOutOfStoreSymlink "${homeDir}/.dotfiles/wlogout";
      ".config/waybar".source =
        config.lib.file.mkOutOfStoreSymlink "${homeDir}/.dotfiles/waybar";
      ".config/walker".source =
        config.lib.file.mkOutOfStoreSymlink "${homeDir}/.dotfiles/walker";
    };
  };
}
