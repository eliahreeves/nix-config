#!/usr/bin/env bash
set -euo pipefail
TAG="${HOST:-$(hostname)}"

pushd "$NH_FLAKE" >/dev/null

alejandra . >/dev/null 2>&1

git add .
if grep -q '^ID=nixos$' /etc/os-release; then
  echo "NixOS Rebuilding..."
  nh os switch
  gen=$(nixos-rebuild list-generations | grep True | awk '{print $1}')
  echo "Rebuild successful, generation $gen"
else
  echo "Home Manager Rebuilding..."
  home-manager switch --flake $HOME/nix-config#$TAG
  echo "Rebuild successful"
fi

popd >/dev/null
