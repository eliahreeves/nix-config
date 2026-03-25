{...}: {
  flake.modules.homeManager.user-core = {pkgs, ...}: {
    home.packages = with pkgs; [
      tree
      waypipe
      ncdu
      jq
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
      fd
      fzf
      wl-clipboard
      imagemagick
    ];
  };
}
