{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    tmux.enable = lib.mkEnableOption "Enable tmux";
  };
  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
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
      ];
      extraConfig = ''
        set -sg escape-time 5
        set -g prefix C-a
        unbind-key C-b
        bind-key C-a send-prefix

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
