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
      gnumake
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
