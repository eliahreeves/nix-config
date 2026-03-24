{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.capslock-arrow-keys = {pkgs, ...}: {
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
