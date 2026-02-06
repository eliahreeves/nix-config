{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "vscode";
  cfg = {
    programs.vscode = {
      enable = true;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
        ];
      };
    };
  };
}
