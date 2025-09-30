{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    xfce-utils.enable = lib.mkEnableOption "Enable xfce-utils";
  };
  config = lib.mkIf config.xfce-utils.enable {
    home.packages = with pkgs; [
      xfce.thunar
      xfce.tumbler
      # xfce.xfconf
      # xfce.exo
    ];
    # home.file = {
    #   ".config/xfce4/helpers.rc".text = ''
    #     [TerminalEmulator]
    #     TerminalEmulator=ghostty
    #     TerminalEmulatorDismissed=true
    #   '';
    # };
  };
}
