{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    battery-notice.enable = lib.mkEnableOption "Enable battery-notice";
  };

  config = lib.mkIf config.battery-notice.enable {
    environment.systemPackages = with pkgs; [
      libnotify
    ];

    systemd.user.services.notification-timer = {
      description = "Send notification every 30 seconds";
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = false;
        ExecStart = pkgs.writeShellScript "notify-wrapper" ''
          export DISPLAY="''${DISPLAY:-:0}"
          export DBUS_SESSION_BUS_ADDRESS="''${DBUS_SESSION_BUS_ADDRESS:-unix:path=$XDG_RUNTIME_DIR/bus}"
          BATTERY_PERCENT=$(cat /sys/class/power_supply/BAT0/capacity)
          ON_AC_POWER=$(cat /sys/class/power_supply/BAT0/status)

          if [[ "$ON_AC_POWER" != "Charging" && $BATTERY_PERCENT -le 15 ]]; then
          	${pkgs.libnotify}/bin/notify-send --urgency=CRITICAL --expire-time=5000 --category=device "Battery Low" "Level: $BATTERY_PERCENT%"
          fi
        '';
      };
    };

    systemd.user.timers.notification-timer = {
      description = "Timer for periodic notifications";
      timerConfig = {
        OnUnitActiveSec = "30s"; # 30 seconds after the service completes
        OnBootSec = "30s"; # Start 30 seconds after boot
        Unit = "notification-timer.service";
      };
      wantedBy = ["timers.target"];
    };
  };
}
