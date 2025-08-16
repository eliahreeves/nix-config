{
  pkgs,
  lib,
  config,
  tag,
  ...
}: let
  rebuild-nix =
    pkgs.writeShellScript "rebuild-nix.sh" (builtins.readFile ./scripts/rebuild-nix.sh);
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
          if [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then tmux attach -t main || tmux new -s main; fi
        ''}
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ${p10k}
        alias rebuild-nix="${rebuild-nix} ${tag}"
      '';
      shellAliases = {
        rcat = "cat";
        cat = "bat";
        nshell = "nix-shell --command $SHELL";
        ndev = "nix develop --command $SHELL";
      };
      syntaxHighlighting.enable = true;
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
