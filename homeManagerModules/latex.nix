{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    latex.enable = lib.mkEnableOption "Enable latex";
  };
  config = lib.mkIf config.latex.enable {
    home.packages = with pkgs; [
      texliveFull
    ];
  };
}
