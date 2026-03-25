{inputs, ...}: {
  flake.modules.homeManager.eko-messenger-client = {pkgs, ...}: {
    home.packages = [
      inputs.eko-messenger-client.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
