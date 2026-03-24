{...}: {
  flake.homeManagerModules.neovim-symlink = {config, ...}: {
    home.file = {
      ".config/nvim".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/modules/wrapped/neovim/config";
    };
  };
}
