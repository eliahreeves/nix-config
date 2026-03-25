{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.amd-gpu = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      rocmPackages.rocm-smi
    ];
  };
}
