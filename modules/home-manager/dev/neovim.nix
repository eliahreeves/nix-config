{
  pkgs,
  config,
  helpers,
  inputs,
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
      nodejs
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
      # verilog
      verible
      clang-tools
      # slang
      inputs.slang-server.packages.${stdenv.hostPlatform.system}.default
    ];
    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
