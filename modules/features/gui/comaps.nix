{...}: {
  flake.modules.nixos.comaps = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [comaps];
  };
}
