#!/usr/bin/env bash

# Colors for 'echo' command
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color

function main() {
	fileFrom=$1
	fileTo=$2

	startTime=$SECONDS

	echo '1. Running rsync...'
	rsyncErr=$(rsync -avP "$fileFrom" "$fileTo" 2>&1 > /dev/null)
	if [ "$rsyncErr" != '' ]; then
		echo -e "${RED}\"rsync\" execution error:${NC}"
		echo "$rsyncErr"
		echo -e "${RED}Quiting...${NC}"
		return
	fi

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
	echo -e "${GREEN}Copied successfully!${NC}"
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
