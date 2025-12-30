{
  lib,
  config,
  ...
}: {
  options = {
    alt-win-swap.enable = lib.mkEnableOption "Swaps the left alt and windows key.";
  };
  config = lib.mkIf config.alt-win-swap.enable {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings = {
          main = {
            leftalt = "leftmeta";
            rightalt = "leftmeta";
            leftmeta = "leftalt";
          };
        };
      };
    };
  };
}
