{self, ...}: {
  flake.modules.nixos.zsh = {
    home-manager.sharedModules = [self.modules.homeManager.zsh];
  };
  flake.modules.homeManager.zsh = {
    pkgs,
    lib,
    config,
    ...
  }: let
    rebuild-nix = pkgs.writeShellScript "rebuild-nix.sh" (
      builtins.readFile ./data/rebuild.sh
    );
    exp = builtins.readFile ./data/open.sh;
    p10k =
      pkgs.writeText ".p10k.zsh" (builtins.readFile ./data/.p10k16.zsh);
  in {
    options.zsh = {
      autolaunchTmux = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Auto-launch tmux session when opening terminal";
      };
      simplify = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "remove themes";
      };
    };

    config = {
      home.packages = with pkgs; [nh git alejandra];
      programs.zsh = {
        enable = true;

        oh-my-zsh = {
          enable = true;
          theme = "";
          plugins = [
            "git"
            "sudo"
          ];
        };

        autosuggestion.enable = true;
        syntaxHighlighting.enable = !config.zsh.simplify;

        plugins = [
          {
            name = "zsh-nix-shell";
            file = "nix-shell.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "chisui";
              repo = "zsh-nix-shell";
              rev = "v0.8.0";
              sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
            };
          }
        ];

        shellAliases = {
          l = "eza --group-directories-first --icons=auto -la";
          rebuild-nix = "${rebuild-nix}";
          rcat = "command cat";
          cat = "bat";
        };

        initContent = ''
                       ${lib.optionalString config.zsh.autolaunchTmux ''
            if [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ] && [ -z "$ZED" ]; then
              tmux attach -t main || tmux new -s main
            fi
          ''}
                       ${lib.optionalString (!config.zsh.simplify) ''
            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
            source ${p10k}
          ''}
          ${exp}
          cpy() {
            rsync -ahPz "$@"
          }
          compdef cpy=rsync
        '';
      };

      home.sessionPath = [
        "/home/erreeves/.local/bin"
      ];
      programs.eza.enable = true;
      programs.bat = {
        enable = true;
        config = {
          paging = "never";
          style = "plain";
        };
      };
    };
  };
}
