# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/doman/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/doman/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/doman/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/doman/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
