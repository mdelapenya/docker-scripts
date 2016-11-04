#!/bin/bash

DEBUG=false

usage() {
	echo "Please use this program with following input parameters:"
	echo "	[-d|--debug]: Prints commands in the output"
	echo "	[-h|--help]: Prints this usage message"
}

while :
do
	case "$1" in
		-d | --debug)
			DEBUG=true

			shift
			;;
		-h | --help)
			usage
			exit 0
			;;
		-* | --*) # End of all options
			usage
			exit 1
			;;
		*)
			break
			;;
	esac
done

#
# Remove those images with no repository and no tag
#
IMAGE_IDS=($(docker images | grep "<none>" | awk '{print $1 $2 " " $3}' | grep "<none><none>" | awk '{print $2}'))

for IMAGE_ID in "${IMAGE_IDS[@]}"
do
        echo "Removing unlinked image with imageId: $IMAGE_ID"

	if [ "$DEBUG" = true ]; then
		echo "docker rmi $IMAGE_ID"
	else
		docker rmi $IMAGE_ID
	fi
done
