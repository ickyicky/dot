setupmac() {
        defaults write com.apple.dock expose-animation-duration -float 0.1
        defaults write -g InitialKeyRepeat -int 12
        defaults write -g KeyRepeat -int 1
        defaults write com.apple.Dock autohide-delay -float 0; killall Dock
        defaults write -g com.apple.mouse.scaling -integer -1
}

check_ssh_add() {
    if [[ "$(ssh-add -l)" == "The agent has no identities." ]] ; then
        ssh-add ~/.ssh/id_rsa
        setupmac
    fi
}


if [[ "$(uname)" == "Darwin" ]]; then
    check_ssh_add
fi
