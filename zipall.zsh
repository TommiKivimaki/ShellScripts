#!/usr/bin/env zsh
# Read recursively all the files in a directory and zip them into an archive.zip.
# Includes also hidden files.

emulate -LR zsh
set -ue

zip_files() {
	if [ -d "$1" ]; then
	        for file in "$1"/*(D); do
			if [ -d "$file" ]; then
				zip_files "${file}"
			else
				zip -u archive.zip "${file}"
			fi
		done
	else
		echo "Folder does not exist"
		exit 128
	fi
}

usage() {
	echo "USAGE: source zipall.zsh <folder>"
	echo "Creates an archive.zip including all the files found from the <folder>"
	echo ""
}

# Check the number of input parameters first
if [ "$#" -ne 1 ]; then
        usage
	exit 1
else
        zip_files "$1"
	exit 0
fi
