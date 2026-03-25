{
  self,
  inputs,
  ...
}: {
  flake.modules.homeManager.niri-utils = {
    pkgs,
    config,
    ...
  }: {
    imports = [self.modules.homeManager.vlc];

    home.packages = with pkgs; [
      python313Packages.ipython
      brightnessctl
      bluetuith
    ];

    home.file = {
      ".config/niri".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/niri";
    };
  };
}
