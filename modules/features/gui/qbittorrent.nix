{...}: {
  flake.modules.nixos.qbittorrent = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      qbittorrent
    ];
    persist.userDirectories = [
      ".cache/qBittorrent"
      ".config/qBittorrent"
      ".local/share/qBittorrent"
    ];
  };
}
