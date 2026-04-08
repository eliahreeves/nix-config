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

      specs.general = with pkgs.vimPlugins;
        [
          blink-cmp
        ]
        ++ [
          (pkgs.vimPlugins.nvim-treesitter.withPlugins (p:
            with p;
              [
                nix
                json
                bash
                python
                query
                diff
                csv
              ]
              ++ lib.optionals config.settings.full [
                c
                cpp
                cmake

                go
                gomod
                gosum
                rust
                sql

                latex
                markdown
                markdown-inline

                lua
                luadoc

                yaml
                toml
                xml
                kdl

                javascript
                typescript
                html
                css

                dart

                dockerfile
              ]))
        ];

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
          # json
          jq
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
          # inputs.slang-server.packages.${pkgs.stdenv.hostPlatform.system}.default
          # C
          clang-tools
          # kdl
          kdlfmt
        ];
    };
  };

  flake.modules.nixos.neovim-full = {
    home-manager.sharedModules = [self.modules.homeManager.neovim-full];
  };

  flake.modules.homeManager.neovim-full = {
    pkgs,
    config,
    lib,
    ...
  }: {
    options.neovim-full.configPath = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/nix-config/modules/wrapped/neovim/config";
      description = "Path to neovim configuration directory";
    };

    config = {
      programs.neovim = {
        withPython3 = false;
        withRuby = false;
        enable = true;
        package =
          self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovim;
      };
      home = {
        sessionVariables = {
          EDITOR = "nvim";
        };
        file = {
          ".config/nvim".source =
            config.lib.file.mkOutOfStoreSymlink config.neovim-full.configPath;
        };
      };
    };
  };

  flake.modules.nixos.neovim = {pkgs, ...}: {
    programs.neovim = {
      enable = true;
      package =
        self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovimMinimal;
    };
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
