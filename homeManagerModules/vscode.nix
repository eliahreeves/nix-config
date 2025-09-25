{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    vscode.enable = lib.mkEnableOption "Enable vscode";
  };
  config = lib.mkIf config.vscode.enable {
    programs.vscode = {
      enable = true;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
        ];
        userSettings = {
          "files.autoSave" = "on";
          "editor.fontFamily" = "CaskaydiaMono NF";
          "telemetry.telemetryLevel" = "off";
        };
      };
    };
  };
}
