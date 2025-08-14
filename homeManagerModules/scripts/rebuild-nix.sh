#!/usr/bin/env bash
set -euo pipefail

pushd "$HOME/nixos-config" >/dev/null

alejandra .

git add .
git --no-pager diff --staged

if grep -q '^ID=nixos$' /etc/os-release; then
	echo "NixOS Rebuilding..."
	if sudo nixos-rebuild switch --flake "$HOME/nixos-config#$1" 2>&1 | tee nixos-switch.log && [ "${PIPESTATUS[0]}" -eq 0 ]; then
		gen=$(sudo nixos-rebuild list-generations | grep True | awk '{print $1}')
		echo "$gen" >>nixos-switch.log
		echo "Rebuild successful, generation $gen"
	else
		popd >/dev/null
		exit 1
	fi
else
	home-manager --flake "$HOME/nixos-config#$1" switch
fi

popd >/dev/null
