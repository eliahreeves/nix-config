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
      settings.config_directory = ./config;

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
                svelte

                dockerfile
                dart
                typst
              ]))
        ];

      runtimePkgs = with pkgs;
        [
          ripgrep
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
          typstyle
          tinymist
        ];
    };
  };

  flake.modules.nixos.neovim-full = {pkgs, ...}: let
    package = self.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
  in {
    home-manager.sharedModules = [self.modules.homeManager.neovim {_module.args = {inherit package;};}];

    persist.userDirectories = [
      ".local/state/nvim"
      ".local/share/nvim"
    ];

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    programs.neovim = {
      enable = true;
      inherit package;
    };
  };

  flake.modules.nixos.neovim = {pkgs, ...}: let
    package = self.packages.${pkgs.stdenv.hostPlatform.system}.neovim-minimal;
  in {
    home-manager.sharedModules = [self.modules.homeManager.neovim {_module.args = {inherit package;};}];

    persist.userDirectories = [
      ".local/state/nvim"
      ".local/share/nvim"
    ];

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    programs.neovim = {
      enable = true;
      inherit package;
    };
  };

  flake.modules.homeManager.neovim = {
    helpers,
    lib,
    package,
    ...
  }: {
    xdg.desktopEntries.nvim-terminal-wrapper = {
      name = "Neovim";
      exec = "${lib.getExe helpers.apps.terminal.package} -e ${lib.getExe package} %F";
      terminal = false;
      icon = "${package}/share/icons/hicolor/128x128/apps/nvim.png";
      mimeType = ["text/plain"];
    };
  };

  perSystem = {pkgs, ...}: {
    packages = {
      neovim = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;
        imports = [self.nvimWrapper];
      };

      neovim-minimal = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;
        settings.full = false;
        imports = [self.nvimWrapper];
      };
    };
  };
}
