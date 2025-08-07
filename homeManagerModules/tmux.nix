{
  pkgs,
  lib,
  config,
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
in {
  options = {
    tmux.enable = lib.mkEnableOption "Enable tmux";
    tmux.prefix = lib.mkOption {
      type = lib.types.string;
      default = "a";
      description = "tmux prefix";
    };
  };
  config = lib.mkIf config.tmux.enable {
    home.packages = with pkgs; [yq-go];
    programs.tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins;
        [
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
        ]
        ++ [
          {
            plugin = layouts;
            extraConfig = ''
                     set -g @layouts-project-paths '~/repos/*;~/nixos-config;~/.dotfiles'
              set -g @layouts-finder-key 'f'
            '';
          }
        ];
      extraConfig = ''
        set -sg escape-time 5
        set -g prefix C-${config.tmux.prefix}
        unbind-key C-b
        bind-key C-${config.tmux.prefix} send-prefix

        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application}#{tmux_mode_indicator}"
        set -g detach-on-destroy off
        set -g renumber-windows on
        set-option -g base-index 1
        setw -g pane-base-index 1

        set-option -g history-limit 50000
        setw -g mode-keys vi
        set-option -g status-position top

        set -g mouse on

        # Bind 'v' to begin selection in copy mode
        bind -T copy-mode-vi v send -X begin-selection

        # Bind 'y' to copy selection and exit
        bind -T copy-mode-vi y send -X copy-pipe-and-cancel "wl-copy"

        # These a rebound so that they don't prompt.
        bind-key & kill-window
        bind-key x kill-pane

        # These are rebound so that they open current path.
        bind c new-window -c "#{pane_current_path}"
        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"

        # lazygit
        bind-key g display-popup -w 90% -h 80% -E "lazygit"

        # bind-key < swap-window -t -1
        # bind-key > swap-window -t +1
        bind-key < swap-window -t -1 \; select-window -t -1
        bind-key > swap-window -t +1 \; select-window -t +1

        # Use Vim-like keys for pane switching
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # Resize panes with Shift + Vim keys
        bind -r H resize-pane -L 5
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r L resize-pane -R 5

        bind -r a last-window
        bind -r C-p previous-window
        bind -r C-n next-window

        # shortcuts with alt
        bind-key -n M-h previous-window
        bind-key -n M-l next-window
        bind-key -n M-c new-window -c "#{pane_current_path}"
        bind-key -n M-x kill-pane

        set -g status-style bg=default
      '';
    };
  };
}
