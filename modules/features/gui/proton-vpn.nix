{...}: {
  flake.modules.nixos.proton-vpn = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [proton-vpn];
    persist.userDirectories = [".cache/Proton"];
  };
}
