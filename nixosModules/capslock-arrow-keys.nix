{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    capslock-arrow-keys.enable = lib.mkEnableOption "Rebinds caps+hjkl to arrow keys.";
  };
  config = lib.mkIf config.capslock-arrow-keys.enable {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings = {
          main = {
            capslock = "overload(capslock, esc)";
          };

          capslock = {
            h = "left";
            j = "down";
            k = "up";
            l = "right";
          };
        };
      };
    };
  };
}
