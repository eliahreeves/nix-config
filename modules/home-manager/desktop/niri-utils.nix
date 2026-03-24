{
  self,
  inputs,
  ...
}: {
  flake.homeManagerModules.niri-utils = {
    pkgs,
    config,
    ...
  }: {
    imports = [self.homeManagerModules.vlc];

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
