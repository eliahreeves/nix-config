{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  layouts = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "layouts";
    version = "0.1.0";
    rtpFilePath = "layouts.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "eliahreeves";
      repo = "tmux-layouts";
      rev = "e98a7a05e9eee5e4e064789779120de19288c7fe";
      sha256 = "sha256-fVJp10cCJPq4HENPh2gcljPUd7Q3Jqu3OO7kp0ZCOUc=";
    };
    postInstall = ''
      sed -i -e 's|\bfzf\b|${pkgs.fzf}/bin/fzf|g' $target/scripts/launch.sh
      sed -i -e 's|\byq\b|${pkgs.yq-go}/bin/yq|g' $target/scripts/launch.sh
    '';
  };
in
  helpers.mkModule config {
    name = "tmux";
    options = {
      prefix = lib.mkOption {
        type = lib.types.str;
        default = "a";
        description = "tmux prefix";
      };
    };
    cfg = cfgValue: {
      home.packages = with pkgs; [yq-go];
      programs.tmux = {
        enable = true;
        prefix = "C-${cfgValue.prefix}";
        plugins = with pkgs.tmuxPlugins; [
          {
            plugin = catppuccin;
            extraConfig = ''
              set -g @catppuccin_flavor 'mocha'
              set -g @catppuccin_window_status_style "rounded"
            '';
          }
          {
            plugin = fingers;
            extraConfig = ''
              set -g @fingers-hint-style "bg=red,fg=black,bold"
              set -g @fingers-backdrop-style "dim"
              set -g @fingers-highlight-style "bg=green,fg=black"
            '';
          }
          mode-indicator
          {
            plugin = layouts;
            extraConfig = ''
              set -g @layouts-project-paths '~/repos/*;~/nix-config;~/.dotfiles;~/.config'
              set -g @layouts-finder-key 'f'
            '';
          }
        ];
        extraConfig = builtins.readFile ./scripts/.tmux.conf;
      };
    };
  }
