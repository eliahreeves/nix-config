{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.no-sleep = {pkgs, ...}: {
    systemd.sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
      AllowHybridSleep=no
      AllowSuspendThenHibernate=no
    '';

    networking.networkmanager.wifi.powersave = false;
  };
}
