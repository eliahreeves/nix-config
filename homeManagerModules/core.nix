{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    core.enable = lib.mkEnableOption "Enable core utils";
  };
  config = lib.mkIf config.core.enable {
    home.packages = with pkgs; [
      ncdu
      fastfetch
      curl
      wget
      btop
      ripgrep
      lazygit
      fd
      imagemagick
    ];
  };
}
