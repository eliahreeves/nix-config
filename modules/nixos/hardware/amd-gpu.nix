{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.amd-gpu = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      rocmPackages.rocm-smi
    ];
  };
}
