{...}: {
  flake.modules.nixos.ericbreh = {pkgs, ...}: {
    users.users.ericbreh = {
      isNormalUser = true;
      description = "Eric";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOanOZf0P4dP7gnyYLQ8WcxTm3ln5rFZE+J/1RhTewVR ericchuang94@gmail.com"
      ];
    };
  };
}
