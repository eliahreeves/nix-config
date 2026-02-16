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
        plugin = ["opencode-gemini-auth@latest" "opencode-qwen-auth"];
        provider = {
          qwen = {
            npm = "@ai-sdk/openai";
            options = {
              baseURL = "https://portal.qwen.ai/v1";
              compatibility = "strict";
            };
            models = {
              qwen3-coder-plus = {};
              qwen3-vl-plus = {attachment = true;};
            };
          };
        };
      };
    };
  };
}
