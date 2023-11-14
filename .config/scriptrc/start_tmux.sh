# run neofetch or tmux if available
if [ ! -z "$(which tmux 2>/dev/null)" ]; then
	if [ ! -n "$TMUX" ] || [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		exec tmux
	fi
fi
