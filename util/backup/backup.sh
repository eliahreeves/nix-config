#!/usr/bin/env bash
MOUNT_POINT="/run/media/erreeves/Backup/"
BACKUP_DIR="computer/"
BACKUP_PATH="${MOUNT_POINT}${BACKUP_DIR}"
LOG_FILE="${BACKUP_PATH}backup.log"

backup() {
  mkdir -p "$BACKUP_PATH$2"
  if [ -n "$3" ]; then
    echo "Backing up $1 to $BACKUP_PATH$2 excluding $3"
    rsync -a --delete --exclude="$3" --info=progress2 "$1" "$BACKUP_PATH$2"
  else
    echo "Backing up $1 to $BACKUP_PATH$2"
    rsync -a --delete --info=progress2 "$1" "$BACKUP_PATH$2"
  fi
  # Log the source and destination paths
  echo "$1|/mnt/${BACKUP_DIR}$2" >>"$LOG_FILE"
}

if ! mountpoint -q $MOUNT_POINT; then
  echo "Backup drive not mounted. Exiting."
  exit 1
fi

# Clear/create the log file
true >"$LOG_FILE"

backup "$HOME/Documents/" Documents
backup "$HOME/repos/secrets/" repos/secrets
backup "$HOME/Pictures/" Pictures "Screenshots"
backup "$HOME/.dotfiles/" .dotfiles
backup "$HOME/.ssh/" .ssh
backup "$HOME/.gnupg/" .gnupg
backup "$HOME/nix-config/" nix-config

echo "Backup complete. Log written to $LOG_FILE"
