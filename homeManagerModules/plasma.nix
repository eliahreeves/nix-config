{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    plasma.enable = lib.mkEnableOption "Enable plasma";
  };
  config = lib.mkIf config.plasma.enable {
    # programs.plasma = {
    #   enable = true;
    #   powerdevil = {
    #     AC.autoSuspend.action = "nothing";
    #     AC.autoSuspend.idleTimeout = -1;
    #     AC.dimDisplay.enable = false;
    #     AC.turnOffDisplay.idleTimeout = -1;
    #     AC.turnOffDisplay.idleTimeoutWhenLocked = -1;
    #     AC.powerProfile = "performance";
    #   };
    #   workspace = {
    #     splashScreen.theme = "None";
    #   };
    #   kscreenlocker = {
    #     autoLock = false;
    #   };
    # };
  };
}
