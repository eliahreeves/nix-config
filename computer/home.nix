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
    brave
    bluetuith
    wl-clipboard
    spotify
    nodejs_24
    dbeaver-bin
  ];

  minecraft.enable = true;
  tmux.enable = true;
  ghostty.enable = true;
  zen-browser.enable = true;
  firefox.enable = true;
  hyprland-utils.enable = nixosConfig.hyprland.enable or false;
  gnome-tools.enable = nixosConfig.hyprland.enable or false;
  theme.enable = true;
  vscode.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  programs = {
    home-manager.enable = true;
    lazygit.enable = true;
  };
}
