{lib, ...}: {
  imports = [
    ./niri-utils.nix
    ./plasma.nix
    ./python.nix
    ./firefox.nix
    ./zed.nix
    ./xfce-utils.nix
    ./obsidian.nix
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
    ./direnv.nix
    ./core.nix
    ./latex.nix
    ./eko-messenger-client.nix
  ];

  core.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  direnv.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;

  eko-messenger-client.enable = lib.mkDefault false;
  niri-utils.enable = lib.mkDefault false;
  plasma.enable = lib.mkDefault false;
  python.enable = lib.mkDefault false;
  latex.enable = lib.mkDefault false;
  xfce-utils.enable = lib.mkDefault false;
  obsidian.enable = lib.mkDefault false;
  hyprland-utils.enable = lib.mkDefault false;
  gnome-tools.enable = lib.mkDefault false;
  vscode.enable = lib.mkDefault false;
  minecraft.enable = lib.mkDefault false;
  tmux.enable = lib.mkDefault false;
  neovim.enable = lib.mkDefault true;
  ghostty.enable = lib.mkDefault false;
  theme.enable = lib.mkDefault false;
  firefox.enable = lib.mkDefault false;
}
