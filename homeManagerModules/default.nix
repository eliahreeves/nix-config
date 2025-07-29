{lib, ...}: {
  imports = [
    ./git.nix
    ./hyprland-utils.nix
    ./vscode.nix
    ./minecraft.nix
    ./zsh.nix
    ./tmux.nix
    ./neovim.nix
    ./ghostty.nix
    ./theme.nix
    ./gnome-tools.nix
    ./zen-browser.nix
    ./direnv.nix
  ];
  git.enable = lib.mkDefault true;
  direnv.enable = lib.mkDefault true;
  hyprland-utils.enable = lib.mkDefault false;
  gnome-tools.enable = lib.mkDefault false;
  vscode.enable = lib.mkDefault true;
  minecraft.enable = lib.mkDefault false;
  zsh.enable = lib.mkDefault true;
  tmux.enable = lib.mkDefault false;
  neovim.enable = lib.mkDefault true;
  ghostty.enable = lib.mkDefault false;
  theme.enable = lib.mkDefault false;
  zen-browser.enable = lib.mkDefault false;
}
