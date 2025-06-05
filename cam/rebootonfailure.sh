#!/bin/bash

DIR_PATH=/media/HD/cctv

while true
do

	if [ ! -d "$DIR_PATH" ]; then
 	    echo "Directory '$DIR_PATH' does not exist."
	    mount /media/HD
	fi

	sleep 10
done
