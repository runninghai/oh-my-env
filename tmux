set -g default-terminal "screen-256color"
set -g mouse on
set -g default-shell /bin/zsh
set -g escape-time 10
setw -g mode-keys vi


# switch pane
bind-key k select-pane -U
bind-key j select-pane -D
bind-key h select-pane -L
bind-key l select-pane -R

bind-key K kill-window


# bind-key s split-window \; resize-pane -D 12
bind-key t split-window -v -l 20% -c "#{pane_current_path}"
bind-key s split-window 
bind-key v split-window -h

set -g @plugin 'tmux-plugins/tmux-resurrect'

run-shell ~/.tmux/plugins/tpm/tpm

###################### gruvbox config
# copy from https://github.com/egel/tmux-gruvbox/blob/main/tmux-gruvbox-dark.conf, 
# cause some options need to be modified, eg status-line
## COLORSCHEME: gruvbox dark (medium)
set-option -g status "on"

# default statusbar color
set-option -g status-style bg=colour237,fg=colour223 # bg=bg1, fg=fg1

# default window title colors
set-window-option -g window-status-style bg=colour214,fg=colour237 # bg=yellow, fg=bg1

# default window with an activity alert
set-window-option -g window-status-activity-style bg=colour237,fg=colour248 # bg=bg1, fg=fg3

# active window title colors
set-window-option -g window-status-current-style bg=red,fg=colour237 # fg=bg1

# pane border
set-option -g pane-active-border-style fg=colour250 #fg2
set-option -g pane-border-style fg=colour237 #bg1

# message infos
set-option -g message-style bg=colour239,fg=colour223 # bg=bg2, fg=fg1

# writing commands inactive
set-option -g message-command-style bg=colour239,fg=colour223 # bg=fg3, fg=bg1

# pane number display
set-option -g display-panes-active-colour colour250 #fg2
set-option -g display-panes-colour colour237 #bg1

# clock
set-window-option -g clock-mode-colour colour109 #blue

# bell
set-window-option -g window-status-bell-style bg=colour167,fg=colour235 # bg=red, fg=bg

## Theme settings mixed with colors (unfortunately, but there is no cleaner way)
#set-option -g status-justify "left"
#set-option -g status-left-style none
#set-option -g status-left-length "80"
#set-option -g status-right-style none
#set-option -g status-right-length "80"
set -g status-justify centre

set-option -g status-left "#[bg=colour241,fg=colour248] #S #[bg=colour237,fg=colour241,nobold,noitalics,nounderscore]"
set-option -g status-right "#[bg=colour237,fg=colour239 nobold, nounderscore, noitalics]#[bg=colour239,fg=colour246] %Y-%m-%d  %H:%M #[bg=colour239,fg=colour248,nobold,noitalics,nounderscore]#[bg=colour248,fg=colour237]  "


set-window-option -g window-status-separator ""
set-window-option -g window-status-current-format "#[bg=colour214,fg=colour237,nobold,noitalics,nounderscore]#[bg=colour214,fg=colour239] #I #[bg=colour214,fg=colour239,bold] #W#{?window_zoomed_flag,*Z,} #[bg=colour237,fg=colour214,nobold,noitalics,nounderscore]"
set-window-option -g window-status-format "#[bg=colour239,fg=colour237,noitalics]#[bg=colour239,fg=colour223] #I #[bg=colour239,fg=colour223] #W #[bg=colour237,fg=colour239,noitalics]"

# vim: set ft=tmux tw=0 nowrap:
