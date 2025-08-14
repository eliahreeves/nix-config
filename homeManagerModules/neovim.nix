{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    neovim.enable = lib.mkEnableOption "Enable neovim";
  };
  config = lib.mkIf config.neovim.enable {
    programs.neovim = {
      enable = true;
    };
    home.file = {
      ".config/nvim".source =
        config.lib.file.mkOutOfStoreSymlink "/home/erreeves/.dotfiles/nvim/.config/nvim";
    };
    home.packages = with pkgs; [
      alejandra
      stylua
      lua-language-server
      shfmt
      bash-language-server
      nixd
    ];
    home.sessionVariables = {
      NIX_NEOVIM = 1;
    };
  };
}
