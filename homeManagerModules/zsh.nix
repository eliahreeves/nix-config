{
  pkgs,
  lib,
  config,
  ...
}: {
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
         rebuild-nixos() {
           $HOME/.dotfiles/no-stow/scripts/rebuild-nix.sh
         }
      push-nixos() {
      	$HOME/.dotfiles/no-stow/scripts/push-nix.sh
      }
    '';
    shellAliases = {
      rcat = "cat";
      cat = "bat";
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
}
