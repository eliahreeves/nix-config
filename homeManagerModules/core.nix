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
      tree
      waypipe
      ncdu
      jq
      uv
      unzip
      zip
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
      btrfs-progs
    ];
  };
}
