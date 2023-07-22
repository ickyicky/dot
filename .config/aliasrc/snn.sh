# scanning
function snn() {
	local name="${1:-output}"
	local format="${2:-png}"
	local resolution="${3:-300}"
	local fname=$name.$format
	scanimage --format $format --progress --device "hpaio:/net/envy_6000_series?ip=192.168.0.45&queue=false" --output-file $fname --resolution $resolution
}
