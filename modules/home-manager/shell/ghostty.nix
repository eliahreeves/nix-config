{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "ghostty";
  cfg = {
    programs.ghostty = {
      enable = true;
    };
    home.file = {
      ".config/ghostty".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/ghostty";
    };

    xdg.desktopEntries = {
      nvim-ghostty = {
        name = "Neovim (Ghostty)";
        genericName = "Text Editor";
        exec = "ghostty -e nvim %F";
        icon = "nvim";
        terminal = false;
        categories = ["Development" "TextEditor"];
        mimeType = ["text/plain" "text/markdown" "application/x-shellscript"];
      };
    };

    home.sessionVariables = {
      TERMINAL = "${pkgs.ghostty}/bin/ghostty";
    };
  };
}
