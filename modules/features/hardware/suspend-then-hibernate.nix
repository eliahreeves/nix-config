{...}: {
  flake.modules.nixos.suspend-then-hibernate = {...}: {
    systemd.sleep.settings.Sleep = {
      HibernateDelaySec = "1h";
    };
    services.logind.settings.Login.HandlePowerKey = "suspend-then-hibernate";
  };
}
