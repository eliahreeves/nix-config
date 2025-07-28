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
        config.lib.file.mkOutOfStoreSymlink "/home/erreeves/.dotfiles/ghostty/.config/ghostty";
    };
  };
}
