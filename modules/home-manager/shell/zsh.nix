{
  pkgs,
  lib,
  config,
  tag,
  helpers,
  ...
}: let
  rebuild-nix = pkgs.writeShellScript "rebuild-nix.sh" (builtins.readFile (pkgs.replaceVars ./scripts/rebuild.sh {
    inherit tag;
  }));
  exp = builtins.readFile ./scripts/open.sh;
  p10k =
    pkgs.writeText ".p10k.zsh" (builtins.readFile ./scripts/.p10k16.zsh);
in
  helpers.mkModule config {
    name = "zsh";
    options = {
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
    cfg = cfgValue: {
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
        syntaxHighlighting.enable = !cfgValue.simplify;

        shellAliases = {
          cpy = ''
            rsync -ahPz "$@"
          '';
          rebuild-nix = "${rebuild-nix}";
          cat = "bat";
          nix-shell = "nix-shell --command $SHELL";
        };

        initContent = ''
               ${lib.optionalString cfgValue.autolaunchTmux ''
            if [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ] && [ -z "$ZED" ]; then
              tmux attach -t main || tmux new -s main
            fi
          ''}
               ${lib.optionalString (!cfgValue.simplify) ''
            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
            source ${p10k}
          ''}
          ${exp}
        '';
      };

      home.sessionPath = [
        "/home/erreeves/.local/bin"
      ];

      programs.bat = {
        enable = true;
        config = {
          paging = "never";
          style = "plain";
        };
      };
    };
  }
