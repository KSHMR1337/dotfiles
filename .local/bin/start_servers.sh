#!/usr/bin/env zsh

SESSION="transfers"
SERVERS_DIR="$HOME/current/servers"
CWD="$(pwd)"

# Kill existing session if it exists
tmux kill-session -t "$SESSION" 2>/dev/null

# Create session with a named window, starting in cwd
tmux new-session -d -s "$SESSION" -n "main" -c "$CWD"

# Pane 0 is now active — split it horizontally to get top (nvim) and bottom
tmux split-window -v -t "$SESSION:main" -l "30%" -c "$SERVERS_DIR"
# Now: pane 0 = top (70%), pane 1 = bottom (30%)

# Split bottom pane (pane 1) into 3 columns
tmux split-window -h -t "$SESSION:main.1" -c "$SERVERS_DIR"
# Now: pane 1 = left, pane 2 = middle

tmux split-window -h -t "$SESSION:main.1" -c "$SERVERS_DIR"
# Now: pane 1 = left, pane 2 = center-left, pane 3 = right — balance them
tmux select-layout -t "$SESSION:main" main-horizontal

# Run nvim in top pane AFTER layout is set
tmux send-keys -t "$SESSION:main.1" "nvim notes.txt" Enter

# Run servers in bottom 3 panes
tmux send-keys -t "$SESSION:main.2" "http_server.py 8000" Enter
tmux send-keys -t "$SESSION:main.3" "sudo python3 -m pyftpdlib --port 21 --write" Enter
tmux send-keys -t "$SESSION:main.4" "sudo smbserver.py share ./ -smb2support" Enter

# Focus nvim
tmux select-pane -t "$SESSION:main.0"

# Attach
tmux attach-session -t "$SESSION"
