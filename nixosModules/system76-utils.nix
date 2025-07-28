{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    system76-utils.enable = lib.mkEnableOption "enables system76-utils";
  };
  config = lib.mkIf config.system76-utils.enable {
    hardware.system76.enableAll = true;
  };
}
