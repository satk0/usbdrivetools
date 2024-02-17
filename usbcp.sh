#!/usr/bin/env bash

fileFrom=$1
fileTo=$2

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

	sleep 1
done
