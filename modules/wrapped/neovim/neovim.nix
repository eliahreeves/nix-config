{
  self,
  inputs,
  ...
}: {
  flake.nvimWrapper = {
    config,
    wlib,
    lib,
    pkgs,
    ...
  }: {
    imports = [wlib.wrapperModules.neovim];

    options.settings.full = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Include full set of language servers and tools";
    };

    config = {
      package = inputs.neovim-nightly.packages.${pkgs.stdenv.hostPlatform.system}.default;

      settings.config_directory = lib.mkIf (!config.settings.full) ./config;

      specs.general = lib.mkIf (config.settings.full) (with pkgs.vimPlugins; [
        nvim-treesitter
        nvim-treesitter.withAllGrammars
      ]);

      extraPackages = with pkgs;
        [
          # nix
          alejandra
          nixd
          # bash
          shfmt
          bash-language-server
          # python
          ruff
          pyright
        ]
        ++ lib.optionals config.settings.full [
          deno
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
          inputs.slang-server.packages.${pkgs.stdenv.hostPlatform.system}.default
          # C
          clang-tools
        ];
    };
  };

  flake.nixosModules.neovim = {
    pkgs,
    config,
    lib,
    ...
  }: {
    options.neovim.full = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Include full set of language servers and tools";
    };

    config = lib.mkMerge [
      {
        programs.neovim = {
          enable = true;
          package =
            if config.neovim.full
            then self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovim
            else self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovimMinimal;
        };
      }
    ];
  };

  perSystem = {pkgs, ...}: {
    packages = {
      myNeovim = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;
        imports = [self.nvimWrapper];
      };

      myNeovimMinimal = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;
        settings.full = false;
        imports = [self.nvimWrapper];
      };
    };
  };
}
