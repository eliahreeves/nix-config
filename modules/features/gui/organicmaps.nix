{...}: {
  flake.modules.nixos.organicmaps = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [organicmaps];
    persist.userDirectories = [".local/share/OMaps"];
  };
}
