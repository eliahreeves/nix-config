{...}: {
  flake.modules.nixos.power-button-sleep = {...}: {
    services.logind.settings.Login.HandlePowerKey = "suspend";
  };
}
