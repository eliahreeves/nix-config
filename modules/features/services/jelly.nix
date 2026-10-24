{...}: {
  flake.modules.nixos.jellyfin = {...}: {
    services.jellyfin = {
      enable = true;
      dataDir = "/srv/jelly";
    };
  };
}
