#!/bin/bash

WHEN=${1}

if [[ -z "$WHEN" ]]
then
        WHEN="week"
fi

echo "Cleaning up untagged images..."

IMAGE_IDS=($(docker images | grep "<none>" | awk '{print $3,$4,$5}' | grep "$WHEN" | awk '{print $1}'))

for IMAGE_ID in "${IMAGE_IDS[@]}"
do
        echo "Removing image with imageId: $IMAGE_ID"
        docker rmi $IMAGE_ID
done
