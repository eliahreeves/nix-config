{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.base = {pkgs, ...}: {
    imports = with self.nixosModules; [locale nix-ld ssl-env];
    security.rtkit.enable = true;

    networking.networkmanager.enable = true;

    programs.zsh.enable = true;

    environment.systemPackages = with pkgs; [
      gnupg
      rsync
      cryptsetup
      vim
      git
    ];
  };
}
