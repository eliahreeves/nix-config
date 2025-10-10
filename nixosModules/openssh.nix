{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    openssh.enable = lib.mkEnableOption "openssh";
  };
  config = lib.mkIf config.openssh.enable {
    services.fail2ban.enable = true;
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        AllowUsers = ["erreeves"];
      };
    };
    users.users.erreeves.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJT4WXnfL1SCvyBo6p3+pUNSBI+ZxyTADd4NzX5GKd0Z ereeclimb@gmail.com"
    ];
  };
}
