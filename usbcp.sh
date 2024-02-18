#!/usr/bin/env bash

function main() {
	fileFrom=$1
	fileTo=$2

	startTime=$SECONDS

	echo '1. Running rsync...'
	rsync -avP "$fileFrom" "$fileTo"

	echo '2. Syncing...'

	sync &
	pID=$!; 
	killErr=""

	while [ "$killErr" = "" ]; do
		killErr=$(kill -0 "$pID" 2>&1 > /dev/null)
		cacheInfo=$(grep -E '(Dirty|Writeback):' /proc/meminfo)

		echo "$cacheInfo"
		sleep 0.5
		
		clearLastLines 2
	done

	echo "$cacheInfo"

	elapsedTime=$(( SECONDS - startTime ))
	echo 'Finished in:'
	date -ud "@$elapsedTime" +'%H hr %M min %S sec'
	#echo "Finished in: $elapsedTime seconds."
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
