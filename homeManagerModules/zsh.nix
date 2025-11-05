{
  pkgs,
  lib,
  config,
  tag,
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
      	sudo nixos-rebuild switch --flake $HOME/nix-config#${tag}
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
in {
  options = {
    zsh.enable = lib.mkEnableOption "Enable zsh";
    zsh.autolaunchTmux = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Auto-launch tmux session when opening terminal";
    };
    zsh.simplify = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "remove themes";
    };
  };
  config = lib.mkIf config.zsh.enable {
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
      initContent = ''
              ${lib.optionalString config.zsh.autolaunchTmux ''
          if [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ] && [ -z "$ZED" ]; then tmux attach -t main || tmux new -s main; fi
        ''}
          ${lib.optionalString (! config.zsh.simplify) ''
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          source ${p10k}
        ''}
              alias rebuild-nix="${rebuild-nix}"
        export PATH="/home/erreeves/.local/bin:$PATH"
        export PATH="/home/erreeves/repos/slang-server/build/bin:$PATH"
      '';
      shellAliases = {
        rcat = "cat";
        cat = "bat";
        nshell = "nix-shell --command $SHELL";
        ndev = "nix develop --command $SHELL";
      };
      syntaxHighlighting.enable = ! config.zsh.simplify;
      autosuggestion.enable = true;
    };
    programs.bat = {
      enable = true;
      config = {
        paging = "never";
        style = "plain";
      };
    };
  };
}
