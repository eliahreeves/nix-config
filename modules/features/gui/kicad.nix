{...}: {
  flake.modules.nixos.kicad = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      kicad
    ];
  };
}
