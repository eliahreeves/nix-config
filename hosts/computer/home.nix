{pkgs, ...}: {
  home.username = "erreeves";
  home.stateVersion = "25.05"; # Please read the comment before changing.
  home.packages = with pkgs; [
    qwen-code
    aerc
    nerd-fonts.caskaydia-mono
    ungoogled-chromium
    gemini-cli
    wl-clipboard
    qbittorrent
    zulip
    spotify
    signal-desktop
    gh
    nh
    nodejs_24
    gocryptfs
    inkscape
    quickemu
    protonvpn-gui
  ];

  xfce-utils.enable = true;
  minecraft.enable = true;
  tmux.enable = true;
  ghostty.enable = true;
  firefox.enable = true;
  eko-messenger-client.enable = true;
  niri-utils.enable = true;
  gnome-tools.enable = true;
  theme.enable = true;
  vscode.enable = true;
  latex.enable = true;
  python.enable = true;
  noctalia.enable = true;
  core.enable = true;
  opencode.enable = true;
  git = {
    enable = true;
    name = "Eliah Reeves";
    email = "ereeclimb@gmail.com";
  };
  direnv.enable = true;
  zsh.enable = true;
  neovim.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    home-manager.enable = true;
    lazygit.enable = true;
  };
}
