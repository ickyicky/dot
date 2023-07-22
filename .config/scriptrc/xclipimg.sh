xclipimg() {
	filename=$1
	mimetype="$(file $1 -b --mime-type)"
	xclip -selection clipboard -t $mimetype -i $filename
}
