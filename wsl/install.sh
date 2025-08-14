#!/usr/bin/env bash

# first install nix

echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf >/dev/null
nix run github:nix-community/home-manager -- switch --flake ~/nixos-config#wsl
