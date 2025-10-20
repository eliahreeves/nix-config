{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    zed.enable = lib.mkEnableOption "Enable zed";
  };
  config = lib.mkIf config.zed.enable {
    programs.zed-editor = {
      enable = true;

      ## This populates the userSettings "auto_install_extensions"
      extensions = ["nix" "toml" "make"];

      ## everything inside of these brackets are Zed options.
      userSettings = {
        # assistant = {
        #   enabled = true;
        #   version = "2";
        #   default_open_ai_model = null;
        #   ### PROVIDER OPTIONS
        #   ### zed.dev models { claude-3-5-sonnet-latest } requires github connected
        #   ### anthropic models { claude-3-5-sonnet-latest claude-3-haiku-latest claude-3-opus-latest  } requires API_KEY
        #   ### copilot_chat models { gpt-4o gpt-4 gpt-3.5-turbo o1-preview } requires github connected
        #   default_model = {
        #     provider = "zed.dev";
        #     model = "claude-3-5-sonnet-latest";
        #   };
        # };

        # node = {
        #   path = lib.getExe pkgs.nodejs;
        #   npm_path = lib.getExe' pkgs.nodejs "npm";
        # };

        auto_update = false;
        terminal = {
          detect_venv = {
            on = {
              directories = [".env" "env" ".venv" "venv"];
              activate_script = "default";
            };
          };
          env = {
            "ZED" = "1";
          };
          font_family = "CaskaydiaMono Nerd Font";
        };
        vim_mode = true;
        ## tell zed to use direnv and direnv can use a flake.nix enviroment.
        load_direnv = "shell_hook";
        theme = {
          mode = "system";
        };
        show_whitespaces = "selection";
        ui_font_size = 18;
        buffer_font_size = 17;
      };
    };
  };
}
