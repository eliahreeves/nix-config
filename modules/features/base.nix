{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.base = {pkgs, ...}: {
    imports = with self.modules.nixos; [locale nix-ld ssl-env];
    security.rtkit.enable = true;

    networking.networkmanager.enable = true;

    programs.zsh.enable = true;

    environment.systemPackages = with pkgs; [
      tree
      waypipe
      ncdu
      unzip
      zip
      fastfetch
      curl
      wget
      btop
      ripgrep
      fd
      wl-clipboard
      imagemagick
      gnupg
      rsync
      cryptsetup
      vim
      git
    ];
  };
}
