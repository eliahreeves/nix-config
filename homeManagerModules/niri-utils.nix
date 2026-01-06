{
  pkgs,
  lib,
  config,
  ...
}: let
  homeDir = "/home/${config.home.username}";
in {
  options = {
    niri-utils.enable = lib.mkEnableOption "Enable niri-utils";
  };
  config = lib.mkIf config.niri-utils.enable {
    home.packages = with pkgs; [
      python313Packages.ipython
      brightnessctl
      bluetuith
      vlc
      libnotify
    ];
    home.file = {
      ".config/niri".source =
        config.lib.file.mkOutOfStoreSymlink "${homeDir}/.dotfiles/niri";
    };
  };
}
