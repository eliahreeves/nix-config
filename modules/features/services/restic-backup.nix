{...}: {
  flake.modules.nixos.restic-backup = {
    config,
    pkgs,
    ...
  }: {
    sops = {
      secrets."restic_backblaze/account_id" = {};
      secrets."restic_backblaze/account_key" = {};
      secrets."restic_backblaze/repo" = {};
      secrets."restic_backblaze/password" = {};
    };
    sops.templates."restic-env".content = ''
      B2_ACCOUNT_ID=${config.sops.placeholder."restic_backblaze/account_id"}
      B2_ACCOUNT_KEY=${config.sops.placeholder."restic_backblaze/account_key"}
      RESTIC_REPOSITORY=${config.sops.placeholder."restic_backblaze/repo"}
      RESTIC_PASSWORD=${config.sops.placeholder."restic_backblaze/password"}
    '';

    systemd.services.restic-backup = {
      description = "Restic backup service for Immich data";
      serviceConfig = {
        Type = "oneshot";
        EnvironmentFile = config.sops.templates."restic-env".path;
        ExecStart = "${pkgs.bash}/bin/bash ${./data/restic-backup.sh}";
        User = "root";
      };
      path = with pkgs; [
        restic
        btrfs-progs
        util-linux
      ];
    };

    systemd.timers.restic-backup = {
      description = "Weekly restic backup timer";
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "weekly";
        Persistent = true;
        RandomizedDelaySec = "1h";
      };
    };
  };
}
