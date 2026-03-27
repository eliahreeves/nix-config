#!/usr/bin/env bash
DISK_LABEL="data"
MOUNT_POINT="/mnt/data_root"
SUBVOL_NAME="immich"
SOURCE_SUBVOL="$MOUNT_POINT/@subvolumes/$SUBVOL_NAME"
BACKUP_SNAPSHOT="$MOUNT_POINT/@subvolumes/${SUBVOL_NAME}_backup"

cleanup() {
  if [ -d "$BACKUP_SNAPSHOT" ]; then
    btrfs subvolume delete "$BACKUP_SNAPSHOT"
  fi
  mountpoint -q "$MOUNT_POINT" && umount "$MOUNT_POINT"
}
trap cleanup EXIT

set -e

restic snapshots >/dev/null 2>&1 || {
  restic init
}

mkdir -p "$MOUNT_POINT"
mount -t btrfs -o subvol=/ "/dev/disk/by-label/$DISK_LABEL" "$MOUNT_POINT"

btrfs subvolume snapshot -r "$SOURCE_SUBVOL" "$BACKUP_SNAPSHOT"

restic backup "$BACKUP_SNAPSHOT" \
  --host "immich-server" \
  --tag "scheduled-backup" \
  --as-path "/$SUBVOL_NAME"
