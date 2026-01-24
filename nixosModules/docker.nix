{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    docker.enable = lib.mkEnableOption "Docker";
  };
  config = lib.mkIf config.docker.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
    };
    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
