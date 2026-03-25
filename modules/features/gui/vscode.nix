{
  self,
  inputs,
  ...
}: {
  flake.modules.homeManager.vscode = {
    pkgs,
    config,
    ...
  }: {
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
