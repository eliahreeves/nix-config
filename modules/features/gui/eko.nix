{
  inputs,
  self,
  ...
}: {
  flake.modules.nixos.eko = {pkgs, ...}: {
    imports = with self.modules.nixos; [kunifiedpush];
    environment.systemPackages = [inputs.eko.packages.${pkgs.stdenv.hostPlatform.system}.default];
  };
}
