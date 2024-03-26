setupmac() {
  defaults write com.apple.dock expose-animation-duration -float 0.1
  defaults write -g InitialKeyRepeat -int 12
  defaults write -g KeyRepeat -int 1
  defaults write com.apple.Dock autohide-delay -float 0
}

function disable_hot_corners(){
  defaults write com.apple.dock "wvous-tl-corner" -int 0
  defaults write com.apple.dock "wvous-tr-corner" -int 0
  defaults write com.apple.dock "wvous-br-corner" -int 0
}

function enable_hot_corners(){
  defaults write com.apple.dock "wvous-tl-corner" -int 2
  defaults write com.apple.dock "wvous-tr-corner" -int 3
  defaults write com.apple.dock "wvous-br-corner" -int 1
}

check_ssh_add() {
  if [[ "$(ssh-add -l)" == "The agent has no identities." ]] ; then
    ssh-add ~/.ssh/id_rsa
    setupmac
    enable_hot_corners

    # Restart Dock
    killall Dock
  fi
}

hc() {
  # Make sure to read from a corner that has an active value > 0
  has_hot_corners=$(defaults read com.apple.dock "wvous-tl-corner")

  # Toggle
  if (( $has_hot_corners != 0 ))
  then
    disable_hot_corners
  else
    enable_hot_corners
  fi

  echo "Hot corners are now:"
  defaults read com.apple.dock "wvous-tl-corner"
  defaults read com.apple.dock "wvous-tr-corner"
  defaults read com.apple.dock "wvous-br-corner"

  # Restart Dock
  killall Dock
}

if [[ "$(uname)" == "Darwin" ]]; then
    check_ssh_add

    export CHROME_EXECUTABLE='/Applications/Chromium.app/Contents/MacOS/Chromium'
fi
