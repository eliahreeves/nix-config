{ lib, ... }:
{
  imports = [
    ./hyprland.nix
    ./home-manager.nix
    ./keyd.nix
  ];
}
