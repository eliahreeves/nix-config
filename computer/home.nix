{
  config,
  pkgs,
  lib,
  nixosConfig ? null,
  ...
}: {
  home.username = "erreeves";
  home.stateVersion = "25.05"; # Please read the comment before changing.
  home.packages = with pkgs; [
    nerd-fonts.caskaydia-mono
    ungoogled-chromium
    gemini-cli
    wl-clipboard
    qbittorrent
    zulip
    spotify
    signal-desktop
    gh
    nodejs_24
    gocryptfs
    opencode
    inkscape
    quickemu
    fontforge-gtk
  ];

  xfce-utils.enable = true;
  minecraft.enable = true;
  tmux.enable = true;
  ghostty.enable = true;
  firefox.enable = true;
  eko-messenger-client.enable = true;
  hyprland-utils.enable = nixosConfig.hyprland.enable or false;
  niri-utils.enable = nixosConfig.niri.enable or false;
  gnome-tools.enable = true;
  theme.enable = true;
  vscode.enable = true;
  latex.enable = true;
  python.enable = true;
  noctalia.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  programs = {
    home-manager.enable = true;
    lazygit.enable = true;
  };
}
