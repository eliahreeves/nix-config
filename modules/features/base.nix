{self, ...}: {
  flake.modules.nixos.base = {pkgs, ...}: {
    imports = with self.modules.nixos; [lazygit locale nix-ld ssl-env persist];
    security.rtkit.enable = true;
    networking.networkmanager.enable = true;
    programs.zsh.enable = true;

    persist.directories = [
      "/var/lib/NetworkManager"
      "/etc/NetworkManager/system-connections"
    ];

    environment.systemPackages = with pkgs; [
      tree
      waypipe
      gdu
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
