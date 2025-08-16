{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    hyprland-utils.enable = lib.mkEnableOption "Enable hyprland-utils";
  };
  config = lib.mkIf config.hyprland-utils.enable {
    home.packages = with pkgs; [
      swaynotificationcenter
      swayosd
      waybar
      walker
      blueberry
      hyprpaper
      hyprpicker
      hyprpolkitagent
      hyprsunset
      hypridle
      hyprlock
      slurp
      grim
      wlogout
    ];
    home.file = {
      ".config/swaync".source =
        config.lib.file.mkOutOfStoreSymlink "/home/erreeves/.dotfiles/swaync";
      ".config/hypr".source =
        config.lib.file.mkOutOfStoreSymlink "/home/erreeves/.dotfiles/hyprland";
      ".config/wlogout".source =
        config.lib.file.mkOutOfStoreSymlink "/home/erreeves/.dotfiles/wlogout";
      ".config/waybar".source =
        config.lib.file.mkOutOfStoreSymlink "/home/erreeves/.dotfiles/waybar";
      ".config/walker".source =
        config.lib.file.mkOutOfStoreSymlink "/home/erreeves/.dotfiles/walker";
    };
  };
}
