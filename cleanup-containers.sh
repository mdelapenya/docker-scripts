#!/bin/bash

EXCLUDED="registry"
WHEN="2 weeks"

usage() {
	echo "Please use this program with following input parameters:"
	echo "	[-d|--debug]: Prints commands in the output"
	echo "	[-h|--help]: Prints this usage message"
	echo "	[-w|--when PATTERN]: Define the time range to delete the containers. If no value is set '2 weeks' will be used"
  echo "	[-x|--excluded CONTAINER NAME]: Define which container name should be excluded from deletion. By default, registry will be never deleted"
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

echo "Cleaning up obsolete containers ($EXCLUDED cannot be deleted this way)..."

CONTAINER_IDS=($(docker ps -a | grep -v "$EXCLUDED" | grep "Exited (" | grep "$WHEN" | awk '{print $1,$10,$11}'))

for CONTAINER_ID in "${CONTAINER_IDS[@]}"
do
	echo "Removing container with containerId: $CONTAINER_ID"

	if [ "$DEBUG" = true ]; then
		echo "docker rm $CONTAINER_ID"
	else
		docker rm $CONTAINER_ID
	fi
done
