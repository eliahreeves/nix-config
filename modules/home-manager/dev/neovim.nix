{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "neovim";
  cfg = cfgValue: {
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter
        nvim-treesitter.withAllGrammars
      ];
    };
    home.file = {
      ".config/nvim".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nvim";
    };
    home.packages = with pkgs; [
      ghostscript
      tree-sitter
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
      # latex
      texlab
      ltex-ls-plus
      # sql
      sql-formatter
      # kdl
      kdlfmt
    ];
    home.sessionVariables = {
      NIX_NEOVIM = 1;
    };
  };
}
