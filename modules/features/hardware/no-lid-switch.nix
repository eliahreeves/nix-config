{self, ...}: {
  flake.modules.nixos.no-lid-switch = {
    config,
    lib,
    ...
  }: {
    services.logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
    };

    home-manager.sharedModules =
      lib.optional config.programs.niri.enable self.modules.homeManager.no-lid-switch;
  };

  flake.modules.homeManager.no-lid-switch = {
    lib,
    pkgs,
    ...
  }: let
    # niri already turns off the laptop panel on lid close when an external
    # monitor is connected, so only blank the screen when the panel is alone.
    lid-close = pkgs.writeShellApplication {
      name = "niri-lid-close";
      runtimeInputs = [pkgs.jq];
      text = ''
        external=$(niri msg --json outputs | jq '[keys[] | select(startswith("eDP") | not)] | length')
        if [ "$external" -eq 0 ]; then
          niri msg action power-off-monitors
        fi
      '';
    };
  in {
    niri.hostConfig = ''
      switch-events {
          lid-close { spawn "${lib.getExe lid-close}"; }
          lid-open { spawn "niri" "msg" "action" "power-on-monitors"; }
      }
    '';
  };
}
