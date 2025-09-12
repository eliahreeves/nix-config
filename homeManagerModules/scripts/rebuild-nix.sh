#!/usr/bin/env bash
set -euo pipefail

pushd "$HOME/nix-config" >/dev/null

alejandra .

git add .
git --no-pager diff --staged

if grep -q '^ID=nixos$' /etc/os-release; then
	echo "NixOS Rebuilding..."
	sudo nixos-rebuild switch --flake "$HOME/nix-config#$1"
	gen=$(sudo nixos-rebuild list-generations | grep True | awk '{print $1}')
	echo "Rebuild successful, generation $gen"
else
	echo "Home Manager Rebuilding..."
	home-manager --flake "$HOME/nix-config#$1" switch
	echo "Rebuild successful"
fi

popd >/dev/null
