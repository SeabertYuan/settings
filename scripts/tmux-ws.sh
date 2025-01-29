#!/bin/sh

case $1 in
    ssh)
        if [[ "$(stat -f -c '%T' ssh_mnt)" =~ "ext2/ext3" ]]; then
            source /home/seabert/ubcssh.sh fs
        fi
        # if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
        #     tmux new-session -d "ssh"\;\
        # fi
        tmux new-session -n "ssh"
        tmux split-window -h -p 30
        tmux split-window -v
        tmux select-pane -t 0
        tmux send-keys "cd ssh_mnt/cs" C-m
        tmux select-pane -t 1
        tmux send-keys "./ubcssh.sh c" C-m
        tmux -2 attach-session -d
        ;;
esac
