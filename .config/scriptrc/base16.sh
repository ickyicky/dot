# Base16 Shell
if ! {[ -n "$TMUX" ] || [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]}; then
	BASE16_SHELL="$HOME/.config/base16-shell/"
	source "$BASE16_SHELL/profile_helper.sh" 2>/dev/null
	BASE16_SHELL_SET_BACKGROUND=false
fi

if ! {[ -n "$TMUX" ] || [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]}; then
	base16_ocean
fi
