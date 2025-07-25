{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "erreeves";
  home.stateVersion = "25.05"; # Please read the comment before changing.
  home.packages = with pkgs; [
    nixfmt-rfc-style
    stylua
    lua-language-server

    firefox
    nautilus
    seahorse
    waybar
    hyprpaper
    hyprpicker
    wlogout
    tmux
    gnumake
    walker
    nerd-fonts.caskaydia-mono
    wl-clipboard
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/hypr".source =
      config.lib.file.mkOutOfStoreSymlink "/home/erreeves/.dotfiles/hyprland/.config/hypr";
    ".config/wlogout".source =
      config.lib.file.mkOutOfStoreSymlink "/home/erreeves/.dotfiles/wlogout/.config/wlogout";
    ".config/waybar".source =
      config.lib.file.mkOutOfStoreSymlink "/home/erreeves/.dotfiles/waybar/.config/waybar";
    ".config/walker".source =
      config.lib.file.mkOutOfStoreSymlink "/home/erreeves/.dotfiles/walker/.config/walker";
    ".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "/home/erreeves/.dotfiles/nvim/.config/nvim";
    ".config/ghostty".source =
      config.lib.file.mkOutOfStoreSymlink "/home/erreeves/.dotfiles/ghostty/.config/ghostty";
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  home.sessionVariables = {
    NIX_NEOVIM = 1;
    GTK_THEME = "Adwaita-dark";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Adwaita-dark";
      color-scheme = "prefer-dark";
    };
  };
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Adwaita";
    size = 24;
    package = pkgs.adwaita-icon-theme;
  };

  programs = {
    home-manager.enable = true;

    neovim = {
      enable = true;
      plugins = with pkgs; [
        vimPlugins.nvim-treesitter.withAllGrammars
      ];
    };
    ghostty = {
      enable = true;
    };
    lazygit.enable = true;
  };
}
