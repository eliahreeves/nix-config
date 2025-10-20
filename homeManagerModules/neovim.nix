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
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter
        nvim-treesitter.withAllGrammars
      ];
    };
    home.file = {
      ".config/nvim".source =
        config.lib.file.mkOutOfStoreSymlink "/home/${config.home.username}/.dotfiles/nvim";
    };
    home.packages = with pkgs; [
      tree-sitter
      mermaid-cli
      ghostscript
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
      basedpyright
      # ts
      vtsls
      eslint
      # rust
      rust-analyzer
      rustfmt
      # latex
      texlab
      ltex-ls-plus
    ];
    home.sessionVariables = {
      NIX_NEOVIM = 1;
    };
  };
}
