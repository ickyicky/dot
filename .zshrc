# DOMAN zshrc
# it requires two plugins and .cache/zsh folder.
# syntax-highlighting and sutosuggestions.
# To install them exec following:
#
#       ZSH_SYNTAX_REPO="https://github.com/zsh-users/zsh-syntax-highlighting.git"
#       ZSH_SUGGEST_REPO="https://github.com/zsh-users/zsh-autosuggestions"
#       mkdir -p ~/.cache/zsh
#       git clone ${ZSH_SUGGEST_REPO} ~/.zsh/zsh-autosuggestions
#       git clone ${ZSH_SYNTAX_REPO} ~/.zsh/zsh-syntax-highlighting 



# Enable colors and change prompt. It also adds this little cute
# line with hg/git version if you cd into repository.
# Prompt changes if line is not wide enought!
autoload -U colors && colors
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_

NEWLINE=$'\n'
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[magenta]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%(6~|...%3~|%~)%{$fg[red]%}]%{$fg[magenta]%}%-50(l:$ :$NEWLINE -> )%{$reset_color%}%b"


zstyle ':vcs_info:*' enable git hg svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[green]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"
zstyle ':vcs_info:hg*' formats "%{${fg[cyan]}%}[%{${fg[green]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"
zstyle ':vcs_info:svn*' formats "%{${fg[cyan]}%}[%{${fg[green]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"

case $TERM in
  tmux-256color)
    export TERM=xterm-256color
    ;;
  tmux*)
    export TERM=xterm
    ;;
esac

# Title
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term|xterm-256color)
    precmd () {
      vcs_info
      print -Pn "\e]0;[%n@%M][%~]%#\a"
    } 
    preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }
    ;;
  screen|screen-256color)
    precmd () { 
      vcs_info
      print -Pn "\e]83;title \"$1\"\a" 
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a" 
    }
    preexec () { 
      print -Pn "\e]83;title \"$1\"\a" 
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a" 
    }
    ;; 
esac

# History in cache directory:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.cache/zsh/history
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY 

# Basic auto/tab complete:
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
compinit
_comp_options+=(globdots)       # Include hidden files.

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# control k and j for moving in history as well
bindkey -v "^K" up-line-or-history
bindkey -v "^J" down-line-or-history

# edit command line in VIM!
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

bindkey -v '^?' backward-delete-char
# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char
bindkey "^[[3~" delete-char

export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Hisotry search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# crtl + arrow
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '\eOH'  beginning-of-line
bindkey '\eOF'  end-of-line

# IMPORTA
if [ ! -z "$(which nvim 2>/dev/null)" ]; then
	export EDITOR=nvim
else
	export EDITOR=vim
fi

# load plugins
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# bind autossugest
bindkey '^ ' autosuggest-accept
bindkey '^l' autosuggest-accept

# exports - local bin, python, brew
export PATH="$HOME/.local/bin:$HOME/.bin:/Users/$USER/Library/Python/3.9/bin:/opt/homebrew/opt/openjdk/bin:/opt/homebrew/opt/libpq/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/.cargo/bin:$PATH"

# mysql client on macos
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/dotnet@6/bin:$PATH"
export PATH="${HOME}/Library/Android/sdk/tools:${HOME}/Library/Android/sdk/platform-tools:${PATH}"
export PATH="${HOME}/go/bin/:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client/lib/pkgconfig"

# Load aliases and shortcuts if existent.
if [ -d "$HOME/.config/aliasrc" ]; then
	for ALIASFILE in $HOME/.config/aliasrc/*; do
		source $ALIASFILE
	done
fi

# Load scripts
if [ -d "$HOME/.config/scriptrc" ]; then
	for SCRIPTFILE in $HOME/.config/scriptrc/*.sh; do
		source $SCRIPTFILE
	done
fi
