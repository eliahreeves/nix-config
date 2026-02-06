{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "opencode";
  cfg = cfgValue: {
    programs.opencode = {
      enable = true;
      settings = {
        plugin = ["opencode-gemini-auth@latest"];
      };
    };
  };
}
