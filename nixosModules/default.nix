{lib, ...}: {
  imports = [
    ./auto-power-profile.nix
    ./hyprland.nix
    ./adwaita-qt.nix
    ./minecraft-server.nix
    ./home-manager.nix
    ./capslock-arrow-keys.nix
    ./system76-utils.nix
    ./power-button-sleep.nix
    ./nix-ld.nix
    ./openssh.nix
    ./immich.nix
    ./nimh-networking.nix
  ];
  system76-utils.enable = lib.mkDefault false;
  adwaita-qt.enable = lib.mkDefault false;
  capslock-arrow-keys.enable = lib.mkDefault false;
  hyprland.enable = lib.mkDefault false;
  power-button-sleep.enable = lib.mkDefault false;
  nix-ld.enable = lib.mkDefault true;
  minecraft-server.enable = lib.mkDefault false;
  auto-power-profile.enable = lib.mkDefault false;
  openssh.enable = lib.mkDefault false;
  immich.enable = lib.mkDefault false;
  nimh-networking.enable = lib.mkDefault false;
}
