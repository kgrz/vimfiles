#!/bin/sh
# Backup History files <= I always delete them playing in the shell

cp "$HOME/.bash_history" "$HOME/Documents/History/history_bash_$OS_$(date +%Y_%m_%d_%H_%M_%S).txt"
cp "$HOME/.tmux_history" "$HOME/Documents/History/history_tmux_$OS_$(date +%Y_%m_%d_%H_%M_%S).txt"
cp "$HOME/.viminfo" "$HOME/Documents/History/history_viminfo_$OS_$(date +%Y_%m_%d_%H_%M_%S).txt"
