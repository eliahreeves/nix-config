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
      waypipe
      lynx
      ncdu
      jq
      uv
      unzip
      fastfetch
      gnumake
      clang
      cmake
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
