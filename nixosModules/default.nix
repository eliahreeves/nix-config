{lib, ...}: {
  imports = [
    ./samba.nix
    ./immich.nix
    ./docker.nix
    ./auto-power-profile.nix
    ./amd-gpu.nix
    ./hyprland.nix
    ./adwaita-qt.nix
    ./battery-notice.nix
    ./minecraft-server.nix
    ./home-manager.nix
    ./capslock-arrow-keys.nix
    ./system76-utils.nix
    ./power-button-sleep.nix
    ./nix-ld.nix
    ./openssh.nix
    ./nimh-networking.nix
    ./ollama.nix
    ./steam.nix
    ./distrobox.nix
    # ./next-cloud.nix
  ];
  # next-cloud.enable = lib.mkDefault false;
  immich.enable = lib.mkDefault false;
  docker.enable = lib.mkDefault false;
  samba.enable = lib.mkDefault false;
  amd-gpu.enable = lib.mkDefault false;
  distrobox.enable = lib.mkDefault false;
  steam.enable = lib.mkDefault false;
  battery-notice.enable = lib.mkDefault false;
  ollama.enable = lib.mkDefault false;
  system76-utils.enable = lib.mkDefault false;
  adwaita-qt.enable = lib.mkDefault false;
  capslock-arrow-keys.enable = lib.mkDefault false;
  hyprland.enable = lib.mkDefault false;
  power-button-sleep.enable = lib.mkDefault false;
  nix-ld.enable = lib.mkDefault true;
  minecraft-server.enable = lib.mkDefault false;
  auto-power-profile.enable = lib.mkDefault false;
  openssh.enable = lib.mkDefault false;
  nimh-networking.enable = lib.mkDefault false;
}
