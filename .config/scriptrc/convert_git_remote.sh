# converts old https remote to ssh
function convert_git_remote() {
	local remote="${1:-origin}"
	new_remote=$(git remote get-url ${remote} | sed 's/https:\/\/github.com\//git@github.com:/' | sed 's/$/.git/')
	git remote set-url ${remote} ${new_remote}
	echo "set ${remote} to ${new_remote}"
}
