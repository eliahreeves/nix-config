{...}: {
  flake.nixosModules.no-sleep = {...}: {
    systemd.sleep.settings.Sleep = {
      AllowSuspend = "no";
      AllowHibernation = "no";
      AllowHybridSleep = "no";
      AllowSuspendThenHibernate = "no";
    };

    networking.networkmanager.wifi.powersave = false;
  };
}
