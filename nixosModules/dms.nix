{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.dms.nixosModules.dank-material-shell
  ];

  options = {
    dms.enable = lib.mkEnableOption "Enable dms";
  };

  config = lib.mkIf config.dms.enable {
    services.upower.enable = true;
    programs.dank-material-shell = {
      enable = true;

      systemd = {
        enable = true;
        restartIfChanged = true;
      };

      enableSystemMonitoring = true;
      enableVPN = true;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableCalendarEvents = true;
    };
  };
}
