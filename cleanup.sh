#!/bin/bash

WHEN=${1}

if [[ -z "$WHEN" ]]
then
        WHEN="week"
fi

./cleanup-containers.sh $WHEN
./cleanup-images.sh $WHEN
