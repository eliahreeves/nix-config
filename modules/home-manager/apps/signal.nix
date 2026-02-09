{
  helpers,
  config,
  pkgs,
  ...
}:
helpers.mkModule config {
  name = "signal";
  cfg = {
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
