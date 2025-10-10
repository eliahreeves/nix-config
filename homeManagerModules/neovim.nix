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
        config.lib.file.mkOutOfStoreSymlink "/home/${config.home.username}/.dotfiles/nvim";
    };
    home.packages = with pkgs; [
      # nix
      alejandra
      nixd
      # lua
      stylua
      lua-language-server
      # bash
      shfmt
      bash-language-server
      # go
      gopls
      gofumpt
      # python
      ruff
      pyright
      # ts
      vtsls
      eslint
      # rust
      rust-analyzer
      rustfmt
    ];
    home.sessionVariables = {
      NIX_NEOVIM = 1;
    };
  };
}
