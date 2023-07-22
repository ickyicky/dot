function cd
{
    if [ $# -eq 0 ]; then
        pushd ~ > /dev/null
    elif [ " $1" = " -" ]; then
        pushd "$OLDPWD" > /dev/null
    else
        pushd "$@" > /dev/null
    fi
}

function cdd
{
    if [ $# -eq 0 ]; then
        cd -
    else
        cd +$1
    fi
}
