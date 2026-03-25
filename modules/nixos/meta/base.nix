{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.base = {pkgs, ...}: {
    imports = with self.modules.nixos; [locale nix-ld ssl-env];
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
