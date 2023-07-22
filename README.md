# Doman DOT

I stole this idea. But it works magic.

## Usage

To setup dotfiles run:

```bash
REPO_URL=git@github.com:ickyicky/dot.git
git clone --bare $REPO_URL $HOME/.dot/
alias dot="/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME"
dot config status.showUntrackedFiles no
dot restore .
source $HOME/.zshrc
```

Then manage dotfiles by dot alias to git, magic!
