{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    obsidian.enable = lib.mkEnableOption "Enable obsidian";
  };
  config = lib.mkIf config.obsidian.enable {
    home.packages = with pkgs; [obsidian];
  };
}
