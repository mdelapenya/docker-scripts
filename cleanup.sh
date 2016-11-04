#!/bin/bash

DEBUG=false
EXCLUDED="registry"
IMAGE=""
WHEN="2 weeks"

usage() {
	echo "Please use this program with following input parameters:"
	echo "	[-d|--debug]: Prints commands in the output"
	echo "	[-h|--help]: Prints this usage message"
	echo "	[-i|--image IMAGE NAME]: Define which image names and tags should be deleted"
	echo "	[-w|--when PATTERN]: Define the time range to delete the images. If no value is set '2 weeks' will be used"
	echo "	[-x|--excluded CONTAINER NAME]: Define which container name should be excluded from deletion. By default, registry will be never deleted"
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
		-x | --excluded)
			EXCLUDED="$2"

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

if [ "$DEBUG" = true ]; then
  ./cleanup-containers.sh -d -w $WHEN -x $EXCLUDED

  ./cleanup-images.sh -d -i $IMAGE -w "$WHEN"

  ./cleanup-orphan-images.sh -d
else
  ./cleanup-containers.sh -w $WHEN -x $EXCLUDED

  ./cleanup-images.sh -i $IMAGE -w "$WHEN"

  ./cleanup-orphan-images.sh
fi
