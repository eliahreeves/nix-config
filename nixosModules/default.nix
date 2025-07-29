{lib, ...}: {
  imports = [
    ./hyprland.nix
    ./home-manager.nix
    ./capslock-arrow-keys.nix
    ./amd-utils.nix
    ./system76-utils.nix
    ./power-button-sleep.nix
    ./nix-ld.nix
  ];
  system76-utils.enable = lib.mkDefault false;
  capslock-arrow-keys.enable = lib.mkDefault true;
  amd-utils.enable = lib.mkDefault false;
  hyprland.enable = lib.mkDefault true;
  power-button-sleep.enable = lib.mkDefault false;
  nix-ld.enable = lib.mkDefault true;
}
