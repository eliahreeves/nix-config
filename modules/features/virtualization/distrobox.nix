{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.distrobox = {pkgs, ...}: {
    virtualisation = {
      containers.enable = true;
      docker = {
        enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      dive
      distrobox
    ];
  };
}
