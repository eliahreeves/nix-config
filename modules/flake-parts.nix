{lib, ...}: {
  options.flake = {
    homeManagerModules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.unspecified;
      default = {};
      description = "Home Manager modules";
    };
  };

  config = {
    systems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  };
}
