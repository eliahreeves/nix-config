{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.openssh = {pkgs, ...}: {
    services.fail2ban.enable = true;
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
