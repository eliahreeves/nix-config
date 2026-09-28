{...}: {
  flake.modules.nixos.distrobox = {pkgs, ...}: {
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
      };
    };

    environment.systemPackages = with pkgs; [
      distrobox
    ];
  };
}
