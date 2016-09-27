#!/bin/bash

WHEN=${1}

if [[ -z "$WHEN" ]]
then
        WHEN="week"
fi

echo "Cleaning up untagged images..."

IMAGE_IDS=($(docker images | grep "<none>" | grep "$WHEN" | awk '{print $3}'))

for IMAGE_ID in "${IMAGE_IDS[@]}"
do
        echo "Removing image with imageId: $IMAGE_ID"
        docker rmi $IMAGE_ID
done
