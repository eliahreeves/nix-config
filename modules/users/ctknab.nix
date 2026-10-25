{...}: {
  flake.modules.nixos.ctknab = {pkgs, ...}: {
    users.users.ctknab = {
      isNormalUser = true;
      description = "Christian";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKZnymIHOfUPHQuCbaW8aPC9lkrV7kHBaE0sEQDaykG3 christiantknab@gmail.com"
      ];
    };
  };
}
