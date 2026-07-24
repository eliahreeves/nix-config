{...}: {
  flake.modules.nixos.journal = {...}: {
    services.journald.extraConfig = ''
      SystemMaxUse=2G
      SystemKeepFree=2G
      MaxRetentionSec=7day
      SystemMaxFileSize=250M
    '';
    persist.directories = ["/var/log"];
  };
}
