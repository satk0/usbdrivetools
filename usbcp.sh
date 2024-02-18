#!/usr/bin/env bash

function main() {
	fileFrom=$1
	fileTo=$2

	start_time=$SECONDS

	echo '1. Running rsync...'
	rsync -avP "$fileFrom" "$fileTo"

	echo '2. Syncing...'

	sync &
	pID=$!; 
	res=""

	while [ "$res" = "" ]; do
		res=$(kill -0 "$pID" 2>&1 > /dev/null)
		tmp=$(grep -E '(Dirty|Writeback):' /proc/meminfo)

		echo "$tmp"
		sleep 0.5
		
		clearLastLines 2
	done

	elapsed_time=$(( SECONDS - start_time ))

	echo "$tmp"
	echo "Finished in: $elapsed_time seconds."
}

# https://stackoverflow.com/a/78015981
function clearLastLines() {
	local linesToClear=$1

	for (( i=0; i<linesToClear; i++ )); do
		tput cuu 1
		tput el
	done
}

main "$@"; exit
