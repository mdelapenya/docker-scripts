#!/bin/bash

WHEN=${1}

if [[ -z "$WHEN" ]]
then
        WHEN="week"
fi

echo "Cleaning up obsolet containers..."

CONTAINER_IDS=($(docker ps -a | grep "Exit" | grep "$WHEN" | awk '{print $1}'))

for CONTAINER_ID in "${CONTAINER_IDS[@]}"
do
        echo "Removing container with containerId: $CONTAINER_ID"
        docker rm $CONTAINER_ID
done
