{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.capslock-ctrl = {pkgs, ...}: {
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
