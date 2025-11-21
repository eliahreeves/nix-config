{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    distrobox.enable = lib.mkEnableOption "enables distrobox";
  };
  config = lib.mkIf config.distrobox.enable {
    virtualisation.containers.enable = true;
    virtualisation = {
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
