{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    power-button-sleep.enable = lib.mkEnableOption "enables power button sleep";
  };
  config = lib.mkIf config.power-button-sleep.enable {
    services.logind.settings.Login.HandlePowerKey = "suspend";
  };
}
