{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "core";
  cfg = {
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
