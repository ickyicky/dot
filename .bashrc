# DOMAN bashrc

# PS1
export PS1="\e[0;31m[\e[m\e[0;33m\u\e[m\e[0;35m@\e[m\e[0;36m\h\e[m \e[0;35m\w\e[m\e[0;31m]\e[m\e[0;35m\\$\e[m \[$(tput sgr0)\]"

# VIM mode
set -o vi

# Load aliases and shortcuts if existent.
if [ -d "$HOME/.config/aliasrc" ]; then
	for ALIASFILE in $(ls $HOME/.config/aliasrc); do
		source "$HOME/.config/aliasrc/$ALIASFILE"
	done
fi

# IMPORTA
if [ ! -z "$(which nvim 2>/dev/null)" ]; then
	export EDITOR=nvim
else
	export EDITOR=vim
fi

# must have function!
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# exports
export PATH="$HOME/.local/bin:$HOME/.bin:$PATH"

# run neofetch!
neofetch 2>/dev/null
. "$HOME/.cargo/env"
