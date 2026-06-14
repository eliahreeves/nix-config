{...}: {
  flake.modules.nixos.flatpack = {pkgs, ...}: {
    services.flatpak.enable = true;
    environment.systemPackages = with pkgs; [gnome-software];
  };
}
