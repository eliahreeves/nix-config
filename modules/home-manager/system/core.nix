{
  self,
  inputs,
  ...
}: {
  flake.homeManagerModules.core = {
    pkgs,
    config,
    ...
  }: {
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
