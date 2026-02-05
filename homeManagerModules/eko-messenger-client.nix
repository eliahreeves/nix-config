{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    eko-messenger-client.enable = lib.mkEnableOption "Enable eko-messenger-client";
  };
  config = lib.mkIf config.eko-messenger-client.enable {
    home.packages = [
      inputs.eko-messenger-client.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
