{
  self,
  inputs,
  ...
}: {
  flake.modules.homeManager.signal = {
    config,
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [signal-desktop];
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/sgnl" = ["signal.desktop"];
        "x-scheme-handler/signalcaptcha" = ["signal.desktop"];
      };
    };
  };
}
