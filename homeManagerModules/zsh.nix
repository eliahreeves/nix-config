{
  pkgs,
  lib,
  config,
  ...
}:
{
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
      			if [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then tmux attach -t main || tmux new -s main; fi
            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
            source /home/erreeves/.dotfiles/p10k/.p10k.zsh
    '';
    shellAliases = {
      cat = "bat";
      rcat = "cat";
    };
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
  };
}
