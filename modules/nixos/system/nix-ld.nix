{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "nix-ld";
  cfg = {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        zlib
        openssl
        curl
        expat
        bzip2
        libffi
        xz
      ];
    };
  };
}
