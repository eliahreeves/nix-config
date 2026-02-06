{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "niri-utils";
  cfg = {
    home.packages = with pkgs; [
      python313Packages.ipython
      brightnessctl
      bluetuith
      vlc
      libnotify
    ];
    home.file = {
      ".config/niri".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/niri";
    };
  };
}
