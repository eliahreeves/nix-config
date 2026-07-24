{...}: {
  flake.modules.nixos.distrobox = {pkgs, ...}: {
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
      };
    };

    persist.userDirectories = [".local/share/containers"];

    environment.systemPackages = with pkgs; [
      distrobox
    ];
  };
}
