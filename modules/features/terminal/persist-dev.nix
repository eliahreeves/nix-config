{...}: {
  flake.modules.nixos.persist-dev = {...}: {
    persist.userDirectories = [
      ".cargo"
      ".config/solana"
      ".rustup"
      ".avm"
      ".cache/solana"
      ".local/share/solana"
    ];
  };
}
