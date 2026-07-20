{...}: {
  flake.modules.nixos.tuned = {...}: {
    services.tuned = {
      enable = true;
    };
    persist.files = ["/etc/tuned/active_profile"];
  };
}
