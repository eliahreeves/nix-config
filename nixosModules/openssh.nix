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
  };
}
