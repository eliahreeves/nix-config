{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nix-ld.enable = lib.mkEnableOption "Enable nix-ld for running unpatched dynamic binaries";
  };
  config = lib.mkIf config.nix-ld.enable {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        zlib
        fuse3
        icu
        nss
        openssl
        curl
        expat
        bzip2
        libffi
        xz
        sqlite
        readline
      ];
    };
  };
}
