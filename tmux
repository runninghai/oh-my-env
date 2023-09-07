set -g default-terminal "screen-256color"
set -g mouse on
set -g default-shell /bin/zsh
set -g escape-time 10

# switch pane
bind-key k select-pane -U
bind-key j select-pane -D
bind-key h select-pane -L
bind-key l select-pane -R


# bind-key s split-window \; resize-pane -D 12
bind-key s split-window -v -l 20% -c "#{pane_current_path}"

set -g @plugin 'egel/tmux-gruvbox'
set -g @tmux-gruvbox 'dark' # or 'light'
set -g @plugin 'tmux-plugins/tmux-resurrect'

run-shell ~/.tmux/plugins/tpm/tpm
