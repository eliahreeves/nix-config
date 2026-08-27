{...}: {
  flake.modules.nixos.tailscale = {...}: {
    services.tailscale.enable = true;
    persist.directories = ["/var/lib/tailscale" "/var/cache/tailscale"];
  };
}
