{
  pkgs,
  lib,
  config,
  tag,
  helpers,
  ...
}: let
  rebuild-nix = pkgs.writeShellScript "rebuild-nix.sh" ''
      #!/usr/bin/env bash
      set -euo pipefail

      pushd "$HOME/nix-config" > /dev/null

    alejandra . > /dev/null 2>&1

      git add .
      if grep -q '^ID=nixos$' /etc/os-release; then
      	echo "NixOS Rebuilding..."
    sudo nixos-rebuild switch --flake $NH_FLAKE#${tag}
      	gen=$(sudo nixos-rebuild list-generations | grep True | awk '{print $1}')
      	echo "Rebuild successful, generation $gen"
      else
      	echo "Home Manager Rebuilding..."
      	home-manager switch --flake $HOME/nix-config#${tag}
      	echo "Rebuild successful"
      fi

      popd >/dev/null
  '';
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
        '';
      };

      home.sessionPath = [
        "/home/erreeves/.local/bin"
        "/home/erreeves/repos/slang-server/build/bin"
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
