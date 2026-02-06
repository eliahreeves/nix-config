{
  pkgs,
  config,
  helpers,
  ...
}: let
  homeDir = config.home.homeDirectory;
in
  helpers.mkModule config {
    name = "hyprland-utils";
    cfg = {
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
