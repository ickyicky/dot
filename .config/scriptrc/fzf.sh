# fzf settings
if [ ! -z "$(which fzf 2>/dev/null)" ]; then
  export FZF_DEFAULT_OPTS="--reverse --bind change:first --bind ctrl-j:down,ctrl-k:up -i --cycle --header-first --border rounded"
  source <(fzf --zsh)
fi
