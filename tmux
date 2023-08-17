set -g default-terminal "screen-256color"
set -g mouse on
set -g default-shell /bin/zsh
set -g escape-time 10

# switch pane
bind-key k select-pane -U
bind-key j select-pane -D
bind-key h select-pane -L
bind-key l select-pane -R

# resize pane
bind-key K resize-pane -U 6
bind-key J resize-pane -D 6
bind-key H resize-pane -L 6
bind-key L resize-pane -R 6


# bind-key s split-window \; resize-pane -D 12
bind-key s split-window -v -l 20% -c "#{pane_current_path}"
