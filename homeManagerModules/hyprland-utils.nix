{
  pkgs,
  lib,
  config,
  ...
}: let
  homeDir = "/home/${config.home.username}";
in {
  options = {
    hyprland-utils.enable = lib.mkEnableOption "Enable hyprland-utils";
  };
  config = lib.mkIf config.hyprland-utils.enable {
    home.packages = with pkgs; [
      swaynotificationcenter
      swayosd
      waybar
      walker
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
