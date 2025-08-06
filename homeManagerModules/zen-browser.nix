{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.zen-browser = {
    enable = lib.mkEnableOption "zen-browser";
  };

  config = lib.mkIf config.zen-browser.enable {
    home.packages = [
      inputs.zen-browser.packages.${pkgs.system}.default
    ];
  };
}
