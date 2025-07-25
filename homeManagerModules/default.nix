{lib, ...}: {
  imports = [
    ./git.nix
    ./vscode.nix
    ./zsh.nix
    ./tmux.nix
  ];
}
