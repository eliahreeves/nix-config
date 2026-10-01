{...}: {
  flake.modules.nixos.docker = {pkgs, ...}: {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
    };
    environment.systemPackages = with pkgs; [
      docker-compose
    ];
    persist.directories = ["/var/lib/docker"];
  };
}
