{inputs, ...}: {
  flake.modules.nixos.sops = {pkgs, ...}: {
    key = "sops.key";
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];
    sops = {
      defaultSopsFile = ../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/home/erreeves/.config/sops/age/keys.txt";
    };
    environment.systemPackages = with pkgs; [sops];
  };
}
