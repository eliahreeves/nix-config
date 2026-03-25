{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.alt-win-swap = {pkgs, ...}: {
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
