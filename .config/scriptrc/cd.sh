function cd
{
    if [ $# -eq 0 ]; then
        pushd ~ > /dev/null
    elif [ " $1" = " -" ]; then
        pushd "$OLDPWD" > /dev/null
    else
        pushd "$1" > /dev/null
    fi

    if [ "$VIRTUAL_ENV" != "" ]; then
      local venvpath=$(dirname $VIRTUAL_ENV)
      case $PWD/ in
        $venvpath/* ) ;;
        *) deactivate;;
      esac
    fi

    if [ -f .venv/bin/activate ]; then
      source .venv/bin/activate
    fi

    if [ $# -gt 1 ]; then
      if [ -f Makefile ]; then
        make ${@:2}
      else
      fi
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

cd $PWD
