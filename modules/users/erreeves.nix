{...}: {
  flake.modules.nixos.erreeves = {pkgs, ...}: {
    users.users.erreeves = {
      isNormalUser = true;
      description = "Eliah Reeves";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJT4WXnfL1SCvyBo6p3+pUNSBI+ZxyTADd4NzX5GKd0Z ereeclimb@gmail.com"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGgePIkD/env+P6ITHLEHWfG88Lfc9okdGiBqT+gRh3R ereeclimb@gmail.com"
      ];
    };
  };
}
