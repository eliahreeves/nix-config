#!/usr/bin/env bash
# Merge ephemeral (tmpfs) home content into the full persistent home.
#
# With selective persist, only listed paths lived under /persistent/home/$USER;
# everything else sat on the tmpfs root and is hidden once /home/$USER is
# bind-mounted as a whole. Run this once before/after switching to
# persist.directories = ["/home/$USER"], then reboot.
#
# Usage:
#   sudo ./util/migrate-home-persist.sh          # apply
#   sudo ./util/migrate-home-persist.sh --dry-run

set -euo pipefail

USER_NAME="${SUDO_USER:-erreeves}"
HOME_DIR="/home/${USER_NAME}"
PERSIST_HOME="/persistent/home/${USER_NAME}"
DRY_RUN=0

if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=1
fi

if [[ "$(id -u)" -ne 0 ]]; then
  echo "error: run as root (sudo)" >&2
  exit 1
fi

if [[ ! -d /persistent ]]; then
  echo "error: /persistent not mounted" >&2
  exit 1
fi

run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf 'dry-run:'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

# Deepest mounts first so parents can be unmounted cleanly.
list_home_mounts() {
  findmnt -R -n -o TARGET "$HOME_DIR" 2>/dev/null | awk 'NF' | sort -r
}

echo "==> home mounts (before):"
list_home_mounts || true

echo "==> unmounting binds under ${HOME_DIR}"
while read -r target; do
  [[ -z "$target" ]] && continue
  echo "    umount ${target}"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    continue
  fi
  if ! umount "$target" 2>/dev/null; then
    umount -l "$target"
  fi
done < <(list_home_mounts)

mkdir -p "$PERSIST_HOME"
mkdir -p "$HOME_DIR"
chown "${USER_NAME}:${USER_NAME}" "$PERSIST_HOME" "$HOME_DIR"

echo "==> ephemeral entries left in ${HOME_DIR}:"
shopt -s nullglob dotglob
ephemeral=("$HOME_DIR"/*)
if [[ ${#ephemeral[@]} -eq 0 ]]; then
  echo "    (none)"
else
  printf '    %s\n' "${ephemeral[@]}"
fi

echo "==> merging into ${PERSIST_HOME}"
for src in "${ephemeral[@]+"${ephemeral[@]}"}"; do
  [[ -e "$src" ]] || continue
  name="$(basename "$src")"
  dest="${PERSIST_HOME}/${name}"

  if [[ -e "$dest" || -L "$dest" ]]; then
    echo "    merge ${src} -> ${dest}"
    if [[ -d "$src" && -d "$dest" ]]; then
      run rsync -aHAX --info=progress2 "$src"/ "$dest"/
      run rm -rf "$src"
    else
      echo "    warning: both exist and are not dirs; leaving ${src} in place" >&2
    fi
  else
    echo "    move  ${src} -> ${dest}"
    run mv "$src" "$dest"
  fi
done
shopt -u nullglob dotglob

echo "==> remounting ${PERSIST_HOME} -> ${HOME_DIR}"
run mount --bind "$PERSIST_HOME" "$HOME_DIR"

echo "==> done"
echo "    Reboot (or nixos-rebuild switch) so preservation owns the mounts."
if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "    (dry-run only; nothing was changed)"
fi
