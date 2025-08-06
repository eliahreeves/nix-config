{
  pkgs,
  lib,
  config,
  ...
}: let
  powerScript = pkgs.writeShellScript "auto_power_mode.sh" ''
    #!/usr/bin/env bash
    ON_AC_POWER=$(cat /sys/class/power_supply/BAT0/status)

    if [[ "$ON_AC_POWER" == "Discharging" ]]; then
            ${pkgs.brightnessctl}/bin/brightnessctl --save
            ${pkgs.system76-power}/bin/system76-power profile battery
            ${pkgs.brightnessctl}/bin/brightnessctl --restore
    else
            ${pkgs.brightnessctl}/bin/brightnessctl --save
            ${pkgs.system76-power}/bin/system76-power profile performance
            ${pkgs.brightnessctl}/bin/brightnessctl --restore
    fi

  '';
in {
  options = {
    auto-power-profile.enable = lib.mkEnableOption "Enable auto-power-profile";
  };
  config = lib.mkIf config.auto-power-profile.enable {
    services.udev.extraRules = ''
      SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${powerScript}"
      SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${powerScript}"
    '';
    systemd.services.set-initial-power-mode = {
      description = "Set power mode based on current power supply at boot";
      wantedBy = ["multi-user.target"];
      after = ["network.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = [powerScript];
      };
    };
  };
}
