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
    nodejs_24
    gocryptfs
    galaxy-buds-client
    gnome-software
  ];

  xfce-utils.enable = true;
  minecraft.enable = true;
  tmux.enable = true;
  ghostty.enable = true;
  firefox.enable = true;
  hyprland-utils.enable = nixosConfig.hyprland.enable or false;
  gnome-tools.enable = nixosConfig.hyprland.enable or false;
  theme.enable = true;
  vscode.enable = true;
  obsidian.enable = true;
  latex.enable = true;
  zed.enable = true;
  python.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  programs = {
    home-manager.enable = true;
    lazygit.enable = true;
  };
}
