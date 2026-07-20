{...}: {
  flake.modules.nixos.persist-dev = {...}: {
    persist.userDirectories = [".cargo"];
  };
}
