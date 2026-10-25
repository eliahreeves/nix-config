{...}: {
  flake.modules.nixos.rlreeves = {pkgs, ...}: {
    users.users.rlreeves = {
      isNormalUser = true;
      description = "Ryan Reeves";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICrsuj0ydqjTHAmiTyVTFsWl3HHGKglxYQVQdlvNa/hL 75mmnorm@gmail.com"
      ];
    };
  };
}
