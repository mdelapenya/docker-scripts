#!/bin/bash

WHEN=${1}

if [[ -z "$WHEN" ]]
then
        WHEN="week"
fi

EXCLUDED=${2}

if [[ -z "$EXCLUDED" ]]
then
        EXCLUDED="registry"
fi

echo "Cleaning up obsolete containers ($EXCLUDED cannot be deleted this way)..."

CONTAINER_IDS=($(docker ps -a | grep -v "$EXCLUDED" | grep "Exited (" | grep "$WHEN" | awk '{print $1}'))

for CONTAINER_ID in "${CONTAINER_IDS[@]}"
do
        echo "Removing container with containerId: $CONTAINER_ID"
        docker rm $CONTAINER_ID
done
