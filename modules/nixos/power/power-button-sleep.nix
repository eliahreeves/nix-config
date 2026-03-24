{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.power-button-sleep = {pkgs, ...}: {
    services.logind.settings.Login.HandlePowerKey = "suspend";
  };
}
