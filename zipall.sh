#!/bin/bash
# Read recursively all the files in a directory and zip them into an archive.zip.
# Includes also hidden files.

set -ue

zip_files() {
	# Check if the folder exists
        if [ -d "$1" ]; then
		# Loop through all the files and folders in the given folder
                for file in $1/*; do
                        if [ -d "$file" ]; then
                                zip_files $file
                        else
                                zip -u archive.zip $file
                        fi
                done
        else
                echo "Folder does not exist"
        fi
}

usage() {
	echo "USAGE: source zipall.sh <folder>"
	echo "Creates an archive.zip including all the files found from the <folder>"
	echo ""
}


# Check the number of input parameters first
if [ "$#" -ne 1 ]; then
        usage
	exit 1
else
        shopt -s nullglob dotglob
	zip_files $1
	exit 0
fi
