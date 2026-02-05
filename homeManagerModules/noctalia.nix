{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  options.noctalia.enable = lib.mkEnableOption "Enable noctalia";
  config = lib.mkIf config.noctalia.enable {
    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;
    };

    services.hypridle = let
      lockScript = pkgs.writeShellScript "lock-screen" ''
        ${config.home.profileDirectory}/bin/noctalia-shell ipc call lockScreen lock
      '';
    in {
      enable = true;
      settings = {
        general = {
          lock_cmd = "${lockScript}";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "niri msg action power-on-monitors";
        };
        listener = [
          {
            timeout = 240;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 300;
            on-timeout = "niri msg action power-off-monitors";
            on-resume = "niri msg action power-on-monitors";
          }
          {
            timeout = 600;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };

    home.file = {
      ".config/noctalia".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/noctalia";
    };
  };
}
