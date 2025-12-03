{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    python.enable = lib.mkEnableOption "Enable python";
  };
  config = lib.mkIf config.python.enable {
    home.packages = with pkgs; [
      (python312.withPackages (p:
        with p; [
          numpy
          pandas
          matplotlib
          seaborn
        ]))
    ];
  };
}
