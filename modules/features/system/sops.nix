{inputs, ...}: {
  flake.modules.nixos.sops = {pkgs, ...}: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];
    sops = {
      defaultSopsFile = ../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/home/erreeves/.config/sops/age/keys.txt";
      secrets.example_secret = {};
    };
    environment.systemPackages = with pkgs; [sops];
  };
}
