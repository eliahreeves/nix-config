{pkgs, ...}: {
  home.username = "erreeves";
  home.stateVersion = "25.05"; # Please read the comment before changing.
  home.packages = with pkgs; [
    aerc
    ungoogled-chromium
    ladybird
    qbittorrent
    zulip
    spotify
    gh
    inkscape
    quickemu
    protonvpn-gui
    gocryptfs
  ];

  signal.enable = true;
  thunar.enable = true;
  minecraft.enable = true;
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
  shell-env.enable = true;
  ai.enable = true;

  programs = {
    home-manager.enable = true;
  };
}
