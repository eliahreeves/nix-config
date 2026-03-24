{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nix-ld = {pkgs, ...}: {
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
