set -g default-terminal "screen-256color"

set -g status-left-length 32
set -g status-right-length 150

set -g status-fg white
set -g status-bg colour234
set -g window-status-activity-attr bold
set -g pane-border-fg colour245
set -g pane-active-border-fg colour39
set -g message-fg colour16
set -g message-bg colour221
set -g message-attr bold

set -g status-left '#[fg=colour235,bg=colour252,bold]'
set -g window-status-format "#[fg=white,bg=colour234] #I #W "
set -g window-status-current-format "#[fg=colour234,bg=colour39]#[fg=colour25,bg=colour39,noreverse,bold] #I #W #[fg=colour39,bg=colour234,nobold]"

set -g status-right '#[bg=colour240,fg=white] #(hostname)@#(hostname -I | cut -d " " -f 1) #[bg=white,fg=colour240] %H:%M #[bg=colour240,fg=white] %Y-%m-%d '
