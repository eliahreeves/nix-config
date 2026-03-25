{...}: {
  flake.modules.homeManager.opencode = {...}: {
    programs.opencode = {
      enable = true;
      settings = {
        plugin = ["opencode-gemini-auth@latest"];
      };
    };
  };
}
