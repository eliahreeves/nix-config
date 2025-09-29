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
      podman = {
        enable = true;
        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    environment.systemPackages = with pkgs; [
      dive
      distrobox
    ];
  };
}
