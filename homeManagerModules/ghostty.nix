{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    ghostty.enable = lib.mkEnableOption "Enable ghostty";
  };
  config = lib.mkIf config.ghostty.enable {
    programs.ghostty = {
      enable = true;
    };
    home.file = {
      ".config/ghostty".source =
        config.lib.file.mkOutOfStoreSymlink "/home/${config.home.username}/.dotfiles/ghostty";
    };

    xdg.desktopEntries = {
      nvim-ghostty = {
        name = "Neovim (Ghostty)";
        genericName = "Text Editor";
        # We use ${pkgs.package} to get the absolute path in the Nix store
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
