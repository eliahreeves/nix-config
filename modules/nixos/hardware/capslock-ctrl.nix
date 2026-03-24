{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.capslock-ctrl = {pkgs, ...}: {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };
}
