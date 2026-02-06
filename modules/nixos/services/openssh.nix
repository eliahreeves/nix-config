{
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "openssh";
  cfg = {
    services.fail2ban.enable = true;
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        AllowUsers = ["erreeves" "rlreeves"];
      };
    };
    users.users.erreeves.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJT4WXnfL1SCvyBo6p3+pUNSBI+ZxyTADd4NzX5GKd0Z ereeclimb@gmail.com"
    ];
    users.users.rlreeves.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICrsuj0ydqjTHAmiTyVTFsWl3HHGKglxYQVQdlvNa/hL 75mmnorm@gmail.com"
    ];
  };
}
