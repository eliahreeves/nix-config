{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.power-button-sleep = {pkgs, ...}: {
    services.logind.settings.Login.HandlePowerKey = "suspend";
  };
}
