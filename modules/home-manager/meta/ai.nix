{
  config,
  helpers,
  pkgs,
  ...
}:
helpers.mkModule config {
  name = "ai";
  cfg = {
    opencode.enable = true;
    home.packages = with pkgs; [
      qwen-code
      gemini-cli
    ];
  };
}
