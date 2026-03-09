{
  pkgs,
  config,
  helpers,
  inputs,
  lib,
  ...
}:
helpers.mkModule config {
  name = "neovim";
  options = {
    full = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Larger config";
    };
  };

  cfg = cfgValue:
    lib.mkMerge [
      {
        programs.neovim.enable = true;
        home.file = {
          ".config/nvim".source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nvim";
        };
        home.packages = with pkgs; [
          # nix
          alejandra
          nixd
          # bash
          shfmt
          bash-language-server
          # python
          ruff
          pyright
        ];
        home.sessionVariables = {
          EDITOR = "nvim";
        };
      }
      (lib.mkIf cfgValue.full {
        programs.neovim.plugins = with pkgs.vimPlugins; [
          nvim-treesitter
          nvim-treesitter.withAllGrammars
        ];
        home.packages = with pkgs; [
          nodejs
          ghostscript
          tree-sitter
          # lua
          stylua
          lua-language-server
          # go
          gopls
          gofumpt
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
          inputs.slang-server.packages.${stdenv.hostPlatform.system}.default
          # C
          clang-tools
        ];
      })
    ];
}
