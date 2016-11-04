#!/bin/bash

DEBUG=false
IMAGE=""
WHEN="2 weeks"

usage() {
	echo "Please use this program with following input parameters:"
	echo "	[-d|--debug]: Prints commands in the output"
	echo "	[-h|--help]: Prints this usage message"
	echo "	[-i|--image IMAGE NAME]: Define which image names and tags should be deleted"
	echo "	[-w|--when PATTERN]: Define the time range to delete the images. If no value is set '2 weeks' will be used"
}

validate_image() {
	if [[ -z "$IMAGE" ]] || [[ "$IMAGE" =~ ^-.* ]] ;
	then
		usage
		exit 1
	fi
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
		-i | --image)
			IMAGE="$2"

			validate_image
			shift 2
			;;
		-w | --when)
			WHEN="$2"

			shift 2
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

validate_image

echo "Cleaning up images for $IMAGE on $WHEN..."

IMAGE_IDS=($(docker images | grep "$IMAGE" | grep "$WHEN" | awk '{print $1":"$2}'))

for IMAGE_ID in "${IMAGE_IDS[@]}"
do
        echo "Removing image with imageId: $IMAGE_ID"

	if [ "$DEBUG" = true ]; then
		echo "docker rmi $IMAGE_ID"
	else
		docker rmi $IMAGE_ID
	fi
done
