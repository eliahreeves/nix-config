{...}: {
  flake.modules.nixos.restic-backup = {config, ...}: {
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
  };
}
